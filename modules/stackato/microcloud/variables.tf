variable "name" {}
variable "stackato_image_name" {}
variable "flavor_name" {}
variable "key_pair_name" {}
variable "private_network_name" {}
variable "public_network_name" {}
variable "security_groups" { type = "list" }
variable "username" { default = "stackato" }

