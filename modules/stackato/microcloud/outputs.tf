output "id" {
  value = "${module.microcloud.id}"
}

output "private_ip" {
  value = "${module.microcloud.private_ip}"
}

output "floating_ip" {
  value = "${module.microcloud.floating_ip}"
}

output "domain" {
  value = "${data.template_file.domain.rendered}"
}

output "username" {
  value = "${var.username}"
}
