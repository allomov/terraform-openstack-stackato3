output "id" { value = "${module.core.id}" }
output "private_ip" { value = "${module.core.private_ip}" }
output "floating_ip" { value = "${module.core.floating_ip}" }
output "username" { value = "${var.username}" }
output "domain" { value = "${data.template_file.domain.rendered}" }
output "system_domain" { value = "api.${data.template_file.init_script.rendered}" }
output "base_domain" { value = "${data.template_file.init_script.rendered}" }

output "state" {
  value = "${
    map(
      "id", "${module.core.id}",
      "private_ip", "${module.core.private_ip}",
      "floating_ip", "${module.core.floating_ip}",
      "username", "${var.username}",
      "domain", "${data.template_file.domain.rendered}",
      "system_domain", "api.${data.template_file.init_script.rendered}",
      "base_domain", "${data.template_file.init_script.rendered}",
    )
  }"
}
