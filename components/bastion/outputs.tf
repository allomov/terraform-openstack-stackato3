# output "id" { value = "${module.bastion.id}" }
# output "private_ip" { value = "${module.bastion.private_ip}" }
# output "floating_ip" { value = "${module.bastion.floating_ip}" }
# output "public_ip" { value = "${module.bastion.floating_ip}" }
# output "username" { value = "${module.bastion.username}" }

# output "state" {
#   value = "${map(
#     "id",          "${module.bastion.id}",
#     "private_ip",  "${module.bastion.private_ip}",
#     "floating_ip", "${module.bastion.floating_ip}",
#     "public_ip",   "${module.bastion.floating_ip}",
#     "username",    "${module.bastion.username}",
#   )}"
# }

# output "infrastructure_state" {
#   value = "${data.terraform_remote_state.infrastructure.state}"
# }

output "security_groupssss" {
  value = "${lookup(data.terraform_remote_state.infrastructure.state, "security_groups")}"
}

# output "security_groups2" {
#   value = "${lookup(lookup(data.terraform_remote_state.infrastructure.state, "security_groups"), "ssh")}"
# }
