module "secondary" {
  source = "../../openstack/node"
  vm_name     = "${element(var.roles, 0)}"
  image_name  = "${lookup(var.infrastructure, "stackato_image_name")}"
  flavor_name = "${lookup(var.infrastructure, "${var.flavor}_flavor_name")}"
  username    = "${var.username}"
  security_groups = [
    "${lookup(var.infrastructure, "security_group_ssh")}",
    "${lookup(var.infrastructure, "security_group_http")}",
    "${lookup(var.infrastructure, "security_group_https")}",
    "${lookup(var.infrastructure, "security_group_private_network")}",
  ]

  infrastructure = "${var.infrastructure}"
}

data "template_file" "init_script" {
  template = "${file("${path.module}/scripts/secondary.sh.tpl")}"
  vars {
    core_ip           = "${lookup(var.core, "private_ip")}"
    first_role        = "${element(var.roles, 0)}"
    add_role_commands = "${join("\n", formatlist("kato role add %s", var.roles))}"
  }
}

resource "null_resource" "secondary_provisioner" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    trigger = "${file(var.trigger) == "" ? false : true}"
  }

  connection {
    type        = "ssh"
    user        = "${module.secondary.username}"
    host        = "${module.secondary.private_ip}"
    private_key = "${file("${var.private_key_path}")}"
    bastion_user        = "${lookup(var.bastion, "username")}"
    bastion_host        = "${lookup(var.bastion, "public_ip")}"
    bastion_private_key = "${file("${var.private_key_path}")}"

    timeout     = "5m"
  }

  provisioner "file" {
    content     = "${file("${var.private_key_path}")}"
    destination = "/home/${module.secondary.username}/.ssh/host_id_rsa"
  }

  provisioner "file" {
    content     = "${file("${var.public_key_path}")}"
    destination = "/home/${module.secondary.username}/.ssh/host_id_rsa.pub"
  }


  provisioner "remote-exec" {
    inline = [
      "${data.template_file.init_script.rendered}"
    ]
  }
}
