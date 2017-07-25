output "id" {
  value = "${module.bastion.id}"
}

output "private_ip" {
  value = "${module.bastion.private_ip}"
}

output "floating_ip" {
  value = "${module.bastion.floating_ip}"
}

output "username" {
  value = "${module.bastion.username}"
}
