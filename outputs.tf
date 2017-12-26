output "grafana public address" {
  value = "${openstack_networking_floatingip_v2.grafana.address}"
}

output "grafana IP" {
  value = "${openstack_compute_instance_v2.grafana.*.access_ip_v4}"
}

output "clients IPs" {
  value =  "${openstack_compute_instance_v2.clients.*.access_ip_v4}"
}

output "debug" {
  value = "${file(var.mgt_ip_file)}"
}

output "debug2" {
  value = "80.80.80.80"
}

output "debug3" {
  value = "./start.sh ${var.space_dir} > start.log 2>&1 &"
}
