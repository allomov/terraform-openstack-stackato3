output "id" {
  value = "${module.microcloud.id}"
}

output "private_ip" {
  value = "${module.microcloud.private_ip}"
}

output "floating_ip" {
  value = "${module.microcloud.floating_ip}"
}

output "username" {
  value = "${var.username}"
}

output "domain" {
  value = "${data.template_file.domain.rendered}"
}

output "system_domain" {
  value = "api.${data.template_file.init_script.rendered}"
}

output "base_domain" {
  value = "${data.template_file.init_script.rendered}"
}

