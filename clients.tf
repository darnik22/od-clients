data "openstack_networking_subnet_v2" "subnet" {
  name = "${var.project}-subnet"
}

data "openstack_networking_network_v2" "network" {
  name = "${var.project}-network"
}

data "openstack_networking_secgroup_v2" "ceph" {
  name = "${var.project}-secgrp-ceph-osd"
}


resource "null_resource" "provision-grafana" {
#  count = "${var.client_count}"
  depends_on = [ "openstack_networking_floatingip_v2.grafana"]
  connection {
    host = "${openstack_networking_floatingip_v2.grafana.address}"
    user     = "${var.ssh_user_name}"
    #    private_key = "${file(var.ssh_key_file)}" # TODO: Use ssh-agent
    agent = true
    timeout = "180s"
  }
  provisioner "file" {
    source = "etc/sources.list"
    destination = "sources.list"
  }
  provisioner "file" {
    source = "bench/dashboard.json"
    destination = "dashboard.json"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo cp sources.list ${var.sources_list_dest}", # if debmirror at #      "sudo apt-add-repository -y 'deb http://nova.clouds.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse'", # if debmirror at OTC is not working
      "echo Instaling python ...",
      "sudo apt-get -y update",
      "sudo apt-get -y install python",
      "sudo apt-get -y install docker.io",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo docker run -d --name go-graphite --restart=always -p 80:80 -p 2003-2004:2003-2004 -p 3000:3000 gographite/go-graphite",
      "sleep 3",
      "curl http://admin:admin@localhost:3000/api/dashboards/db -X POST -d @dashboard.json -H 'Content-Type: application/json'",
    ]
  }
}

resource "openstack_networking_floatingip_v2" "grafana" {
  depends_on = ["openstack_compute_instance_v2.grafana"]
  port_id  = "${openstack_networking_port_v2.grafana-port.0.id}"
#  count = "${var.client_count}"
  pool  = "${var.external_network}"
}

resource "openstack_compute_instance_v2" "grafana" {
  name            = "${var.project}-grafana"
  image_name      = "${var.image_name}"		
  flavor_name     = "${var.client_flavor_name}"
  key_pair        = "${openstack_compute_keypair_v2.otc.name}"
  availability_zone = "${var.availability_zone}"

  network {
    port = "${openstack_networking_port_v2.grafana-port.0.id}"
  }
}

resource "openstack_networking_port_v2" "grafana-port" {
  name = "${var.project}-grafana-port}"
  network_id         = "${data.openstack_networking_network_v2.network.id}"
  security_group_ids = [
     "${openstack_compute_secgroup_v2.grafana.id}",
  ]
  admin_state_up     = "true"
  fixed_ip           = {
#    subnet_id        = "${var.subnet_id}"
    subnet_id        = "${data.openstack_networking_subnet_v2.subnet.id}"
  }
}

data "template_file" "start_bench" {
  template = "${file("bench/start.sh.tpl")}"
  vars {
    graphite_host = "${openstack_compute_instance_v2.grafana.access_ip_v4}"
  }
}

data "template_file" "collectd" {
  template = "${file("etc/collectd.conf.tpl")}"
  vars {
    graphite_host = "${openstack_compute_instance_v2.grafana.access_ip_v4}"
  }
}

resource "null_resource" "provision-clients-python" {
  count = "${var.client_count}"
  depends_on = [ "openstack_compute_instance_v2.clients"]
  triggers {
    clients = "${element(openstack_compute_instance_v2.clients.*.id, count.index)}"
  }
  connection {
    bastion_host     = "${trimspace(file(var.mgt_ip_file))}"
    host = "${element(openstack_compute_instance_v2.clients.*.access_ip_v4, count.index)}"
    user     = "${var.ssh_user_name}"
    #    private_key = "${file(var.ssh_key_file)}" # TODO: Use ssh-agent
    agent = true
    timeout = "120s"
  }
  provisioner "file" {
    source = "etc/sources.list"
    destination = "sources.list"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo cp sources.list ${var.sources_list_dest}", # if debmirror at #      "sudo apt-add-repository -y 'deb http://nova.clouds.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse'", # if debmirror at OTC is not working
      "echo Instaling python ...",
      "sudo apt-get -y update",
      "sudo apt-get -y install python",
    ]
  }
}

resource "null_resource" "provision-clients-mgt" {
  count = "${var.client_count}"
  depends_on = [ "null_resource.provision-clients-python"]
  triggers {
    python = "${element(null_resource.provision-clients-python.*.id, count.index)}"
  }
  connection {
    host     = "${trimspace(file(var.mgt_ip_file))}"
    user     = "${var.ssh_user_name}"
    #    private_key = "${file(var.ssh_key_file)}" # TODO: Use ssh-agent
    agent = true
    timeout = "120s"
  }
  provisioner "remote-exec" {
    inline = [
      "scp -o StrictHostKeyChecking=no /etc/hosts ${element(openstack_compute_instance_v2.clients.*.access_ip_v4, count.index)}:/tmp/hosts",
      "echo After scp .....",
    ]
  }
}

# Provision for clients should be done by the ceph mgt node. Clients addresses and names
# should be copied to mgt. May be to a different file than /etc/ansible/hosts, so the
# deleting of clients wold be easier. The playbook should test first if the clients are up.
resource "null_resource" "provision-clients-mount" {
  count = "${var.client_count}"
  depends_on = [ "null_resource.provision-clients-mgt"]
  triggers {
    python = "${element(null_resource.provision-clients-mgt.*.id, count.index)}"
  }
  connection {
    bastion_host     = "${trimspace(file(var.mgt_ip_file))}"
    host = "${element(openstack_compute_instance_v2.clients.*.access_ip_v4, count.index)}"
    user     = "${var.ssh_user_name}"
    agent = true
    timeout = "120s"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/hosts /etc/hosts",
      "curl -sS  http://get.onedata.org/oneclient.sh | bash",
      "mkdir onedata",
      "oneclient -u onedata",
      "oneclient -H ${var.op_host} -t ${var.access_token} ${var.oneclient_opts} onedata",
    ]
  }
}

# Provision collectd to Ceph cluster and oneprovider  
resource "null_resource" "provision-collectd" {
#  count = "${var.client_count}"
#  depends_on = [ "null_resource.provision-clients-mount", "null_resource.provision-grafana"]
  triggers {
#    mount = "${element(null_resource.provision-clients-mount.*.id, count.index)}"
    grafana = "${openstack_compute_instance_v2.grafana.access_ip_v4}"
  }
  connection {
    host     = "${trimspace(file(var.mgt_ip_file))}"
#    host = "${element(openstack_compute_instance_v2.clients.*.access_ip_v4, count.index)}"
    user     = "${var.ssh_user_name}"
    agent = true
    timeout = "120s"
  }
  provisioner "file" {
    content = "${data.template_file.collectd.rendered}"
    destination = "collectd.conf"
  }
  provisioner "file" {
    source = "collectd.yml"
    destination = "collectd.yml"
  }
  provisioner "remote-exec" {
    inline = [
      "ansible-playbook collectd.yml",
    ]
  }
}

resource "null_resource" "provision-clients-bench" {
  count = "${var.client_count}"
  depends_on = [ "null_resource.provision-clients-mount", "null_resource.provision-grafana"]
  triggers {
    mount = "${element(null_resource.provision-clients-mount.*.id, count.index)}"
    grafana = "${openstack_compute_instance_v2.grafana.access_ip_v4}"
  }
  connection {
    bastion_host     = "${trimspace(file(var.mgt_ip_file))}"
    host = "${element(openstack_compute_instance_v2.clients.*.access_ip_v4, count.index)}"
    user     = "${var.ssh_user_name}"
    agent = true
    timeout = "120s"
  }
  provisioner "file" {
    source = "bench/mbench.py"
    destination = "mbench.py"
  }
  provisioner "file" {
    content = "${data.template_file.start_bench.rendered}"
    destination = "start.sh"
  }
  provisioner "file" {
    content = "${data.template_file.collectd.rendered}"
    destination = "collectd.conf"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt -y install collectd collectd-utils",
      "sudo cp collectd.conf /etc/collectd/collectd.conf",
      "sudo systemctl restart collectd",
      "echo echo1",
      "echo a > ${var.space_dir}/`hostname`.tst",
      "sleep 5",
      "echo echo2",
      "echo a > ${var.space_dir}/`hostname`.tst",
      "echo echo3",
      "rm ${var.space_dir}/`hostname`.tst",
      "echo echo4",
      "chmod +x start.sh",
      "chmod +x mbench.py",
      "echo Testing....",
      "nohup ./start.sh ${var.space_dir}",
      "sleep 5"
    ]
  }
}

resource "openstack_compute_instance_v2" "clients" {
  count           = "${var.client_count}"
  name            = "${var.project}c-client-${format("%02d", count.index+1)}"
  image_name      = "${var.image_name}"				#"bitnami-ceph-osdstack-7.0.22-1-linux-centos-7-x86_64-mp"
  flavor_name     = "${var.client_flavor_name}"
  key_pair        = "${openstack_compute_keypair_v2.otc.name}"
  availability_zone = "${var.availability_zone}"

  network {
    port = "${element(openstack_networking_port_v2.clients-port.*.id, count.index)}"
  }
}

resource "openstack_networking_port_v2" "clients-port" {
  count              = "${var.client_count}"
  name = "${var.project}-clients-port-${format("%02d", count.index+1)}"
  network_id         = "${data.openstack_networking_network_v2.network.id}"
#  network_id         = "${var.network_id}"
  security_group_ids = [
     "${openstack_compute_secgroup_v2.clients.id}",
     "${data.openstack_networking_secgroup_v2.ceph.id}",
  ]
  admin_state_up     = "true"
  fixed_ip           = {
    subnet_id        = "${data.openstack_networking_subnet_v2.subnet.id}"
#    subnet_id        = "${var.subnet_id}"
  }
}

resource "openstack_compute_keypair_v2" "otc" {
  name       = "${var.project}-otc-cl"
  public_key = "${file("${var.public_key_file}")}"
}

provider "openstack" {
  user_name   = "${var.otc_username}"
  password    = "${var.otc_password}"
  tenant_name = "${var.otc_tenant_name}"
  domain_name = "${var.otc_domain_name}"
  auth_url    = "${var.endpoint}"
}

resource "openstack_compute_secgroup_v2" "clients" {
  name        = "${var.project}-secgrp-clients"
  description = "Onedata Clients Security Group"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
  rule {
    from_port   = 1
    to_port     = 65535
    ip_protocol = "tcp"
    self        = true
  }
}

resource "openstack_compute_secgroup_v2" "grafana" {
  name        = "${var.project}-secgrp-grafana"
  description = "Grafana Security Group"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
  rule {
    from_port   = 8080
    to_port     = 8080
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
  rule {
    from_port   = 1
    to_port     = 65535
    ip_protocol = "tcp"
    from_group_id = "${openstack_compute_secgroup_v2.clients.id}"
  }
  rule {
    from_port   = 1
    to_port     = 65535
    ip_protocol = "tcp"
    from_group_id = "${data.openstack_networking_secgroup_v2.ceph.id}"
  }
  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
  rule {
    from_port   = 1
    to_port     = 65535
    ip_protocol = "tcp"
    self        = true
  }
}

