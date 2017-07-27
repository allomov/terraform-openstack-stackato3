variable "default_flavor_name" { default = "m1.medium" }
variable "small_flavor_name"   { default = "m1.small" }

variable "private_key_path"    { default = "~/.ssh/id_rsa" }
variable "public_key_path"     { default = "~/.ssh/id_rsa.pub" }

variable "openstack_public_network_name" {}

