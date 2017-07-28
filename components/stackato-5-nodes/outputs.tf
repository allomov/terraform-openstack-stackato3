data "template_file" "welcome_message" {
  template = "\n\nWelcome!\nUse following command to access Stackato:\n\n\t\tstackato target api.$${domain}\n\n"
  vars {
    domain = "${module.core.domain}"
  }
}

output "welcome_message" {
  value = "${data.template_file.welcome_message.rendered}"
}
