variable "vm_name"          { default = "secondary" }
variable "username"         { default = "stackato" }
variable "private_key_path" { default = "~/.ssh/id_rsa" }
variable "public_key_path"  { default = "~/.ssh/id_rsa.pub" }
variable "flavor"           { default = "default" }


variable "infrastructure" {
  type = "map"
  description = "Infrastructure state hash. See infrastructure component outputs."
}

variable "bastion" {
  type = "map"
  description = "Bastion state hash. See bastion component outputs."
}

variable "core" {
  type = "map"
  description = "Core node module state hash."
}

variable "roles" {
  type = "list"
  description = "Node roles."
}

# https://github.com/hashicorp/terraform/issues/10462
variable "trigger" { type = "string" }