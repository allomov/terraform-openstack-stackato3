variable "prefix"    { default = "stackato3" }

variable "openstack_identity_endpoint" {}
variable "openstack_username" {}
variable "openstack_password" {}
variable "openstack_domain_name" {}

variable "openstack_tenant_name" {}
variable "openstack_public_network_id" {}
variable "openstack_availability_zone" {}

variable "private_key_path" { default = "~/.ssh/id_rsa" }
variable "public_key_path"  { default = "~/.ssh/id_rsa.pub" }
variable "key_pair_name"    { default = "stackato3" }

variable "openstack_region"    { default = "regionOne" }
variable "network"             { default = "10.10" }
variable "offset"              { default = "0" }
variable "default_image_name"  { default = "Ubuntu 16.04" }
variable "default_flavor_name" { default = "m1.medium" }
variable "small_flavor_name"   { default = "m1.small" }

variable "jumpbox_image_name"  { default = "Ubuntu 16.04" }
variable "jumpbox_user" { default = "ubuntu" }

