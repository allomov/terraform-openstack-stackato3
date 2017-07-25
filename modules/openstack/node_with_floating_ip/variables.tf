variable "name" {}
variable "image_name" {}
variable "flavor_name" {}
variable "key_pair_name" {}
variable "private_network_name" {}
# variable "private_network_id" {}

variable "floating_network_name" {}
# variable "floating_network_id" {}
variable "security_groups" { type = "list" }

variable "username" { default = "ubuntu" }
variable "prefix"   { default = "stackato3" }
