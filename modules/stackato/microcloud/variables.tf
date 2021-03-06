variable "vm_name" { default = "microcloud" }
variable "username" { default = "stackato" }
variable "domain" { default = "" }
variable "private_key_path" { default = "~/.ssh/id_rsa" }

variable "infrastructure" {
  type = "map"
  description = "Infrastructure state hash. See infrastructure component outputs."
}
