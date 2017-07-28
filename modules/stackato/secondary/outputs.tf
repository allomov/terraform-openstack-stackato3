output "id" { value = "${module.secondary.id}" }
output "private_ip" { value = "${module.secondary.private_ip}" }
output "username"   { value = "${var.username}" }

output "init" {
  value = "${data.template_file.init_script.rendered}"
}

output "state" {
  value = "${
    map(
      "id", "${module.secondary.id}",
      "private_ip", "${module.secondary.private_ip}",
      "username", "${var.username}",
    )
  }"
}