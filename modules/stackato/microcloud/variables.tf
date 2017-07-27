variable "stackato_image_name" {}
variable "flavor_name" {}
variable "key_pair_name" {}
variable "private_network_name" {}
variable "public_network_name" {}

variable "security_groups" {
  type = "list"
}

variable "name" {
  default = "stackato-microcloud"
}

variable "username" {
  default = "stackato"
}

variable "domain" {
  default = ""
}

variable "private_key_path" {
  default = "~/.ssh/id_rsa"
}
