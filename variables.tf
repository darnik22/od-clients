### OpenStack Credentials
variable "otc_username" {}

variable "otc_password" {}

variable "otc_domain_name" {}

### Project Settings
# The name of the project. It is used to prefix VM names. It should be unique among
# OTC as it is used to create names of VMs. The first provider will have the following
# FQDN: ${project}-op-01.${dnszone} publicly accessible.
variable "project" {
#   default = "od"
}

### Onedata related variables
# The public DNS zone to be created in OTC. There should be a registred domain of
# the same name under your control. The domain should use the following nameservers:
#   - ns1.open-telekom-cloud.com
#   - ns2.open-telekom-cloud.com
# variable "dnszone" {
# #  default = ""
# }

# A valid email will be needed when creating cerificates
# variable "email" {
# #  default = ""
# }

# The onezone managing your space  - the one which is going to be supported by the
# oneprovider 
variable "onezone" {
  default = "https://onedata.hnsc.otc-service.com"
}

# # Your onedata request support token 
# variable "support_token" {
# #  default = ""
# }

# Your onedata access token
variable "access_token" {
   default = "x"
}

### The following variables can optionally be set. Reasonable defaults are provided.

### Ceph cluster settings
# This is the number of management nodes. It should be 1.
variable "ceph-mgt_count" {
  default = "1"
}

# The number of monitors of Ceph cluster. 
variable "ceph-mon_count" {
  default = "1"
}

# The number of VM for running OSDs.
variable "ceph-osd_count" {
  default = "3"
}

### VM (Instance) Settings
# The flavor name used for Ceph monitors and OSDs. 
variable "flavor_name" {
  default = "h1.large.4"
#  default = "hl1.8xlarge.8" # Setting this flavor may require setting vol_type and vol_prefix
}

# The image name used for all instances
variable "image_name" {
  #  default = "Community_Ubuntu_16.04_TSI_latest"
  default = "Community_Ubuntu_16.04_TSI_20171116_0"
}

# Availability zone 
variable "availability_zone" {
  default = "eu-de-01"
}

# The size of elastic volumes which will be attached to the OSDs. The size is given in GB.
variable "vol_size" {
  default = "100"
}

# The type volume. It specifies the performance of a volume. "SSD" maps to "Ultra High I/O".
variable "vol_type" {
  default = "SSD"
#  default = "co-p1"
}

# The number of disks to attach to each VM for running OSDs. The raw Ceph total capacity
# will be (osd_count * disks-per-osd_count * vol_size) GB.
variable "disks-per-osd_count" {
  default = "2"
}

# The number of client VMs
variable "client_count" {
  default = "2"
}

# The flavor for clients
variable "client_flavor_name" {
  default = "h1.large.4"
}

# The number of oneprovider nodes
variable "provider_count" {
  default = "1"
}

# The flavor for provider nodes
variable "provider_flavor_name" {
  default = "h1.xlarge.4"
}


### OTC Specific Settings
variable "otc_tenant_name" {
  default = "eu-de"
}

variable "endpoint" {
  default = "https://iam.eu-de.otc.t-systems.com:443/v3"
}

variable "external_network" {
  default = "admin_external_net"
}

#### Internal usage variables ####
# The user name for loging into the VMs.
variable "ssh_user_name" {
  default = "ubuntu"
}

# Path to the ssh key. The key should not be password protected.
# The mkkeys.sh script can be used to generate the a new key pair if the directory
# "keys" does not exist or is epmpty.
# The key will be copied to the management node.
variable "public_key_file" {
  default = "~/.ssh/id_rsa.pub"
}

variable "sources_list_dest" {
#  default = "/dev/null"
  default = "/etc/apt/sources.list"   # Use this if OTC debmirror has problems
}

variable "storage_type" {
#  default = "posix"    # the data in the Ceph cluster are accessed via CephFS
  default = "ceph"    # the data in the Ceph cluster are accessed natively via rados
}

variable "oneclient_opts" {
  default = "--force-direct-io"
}

# The disk device naming (prefix) for the given flavor.
variable "vol_prefix" {
  default = "/dev/xvd"
#  default = "/dev/vd"
}

# # Use "openstack subnet list | grep <project>" to get the subnet_id and network_id
# variable "subnet_id" {
#   default = "2c67f208-9852-463b-90a3-730774df90cc"
# }

# variable "network_id" {
#   default = "244b744d-cea7-4ca1-b9ac-df02a8590941"
# }

variable "mgt_ip_file" {
  default = "../ceph-tf/MGT_IP"
}

# The oneprovider hostname used in the oneclient command
variable "op_host" {
  default = "daro9-op-01.darosys.eu"
}

# The path to supported space as seen by clients 
variable "space_dir" {
  default = "onedata/ceph"
}

