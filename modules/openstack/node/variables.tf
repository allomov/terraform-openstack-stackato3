variable "vm_name"         {}
variable "security_groups" { type = "list" }
variable "image_name"      {}
variable "flavor_name"     {}
variable "username"        {}

variable "infrastructure" {
  type = "map"
  description = "Infrastructure state hash. See infrastructure component outputs."
}
