output "id" { value = "${module.bastion.id}" }
output "private_ip" { value = "${module.bastion.private_ip}" }
output "floating_ip" { value = "${module.bastion.floating_ip}" }
output "public_ip" { value = "${module.bastion.floating_ip}" }
output "username" { value = "${module.bastion.username}" }



output "state" {
  value = "${
    map(
      "id",          "${module.bastion.id}",
      "private_ip",  "${module.bastion.private_ip}",
      "floating_ip", "${module.bastion.floating_ip}",
      "public_ip",   "${module.bastion.floating_ip}",
      "username",    "${module.bastion.username}"
    )
  }"
}
