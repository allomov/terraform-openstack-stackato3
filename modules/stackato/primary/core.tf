module "core" {
  source = "../../openstack/node_with_floating_ip"
  vm_name     = "core"
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

data "template_file" "domain" {
  template = "$${final_domain}"

  vars {
    final_domain = "${var.domain == "" ? data.template_file.domain_with_xip_io.rendered : var.domain}"
  }
}

data "template_file" "domain_with_xip_io" {
  template = "$${public_ip_address}.xip.io"

  vars {
    public_ip_address = "${module.core.floating_ip}"
  }
}

data "template_file" "init_script" {
  template = "${file("${path.module}/scripts/core.sh.tpl")}"
  vars {
    domain = "${data.template_file.domain.rendered}"
  }
}

resource "null_resource" "core_provisioner" {
  # Changes to any instance of the cluster requires re-provisioning
  depends_on = [ "module.core" ]
  triggers {
    core_ip = "${module.core.id}"
  }

  connection {
    type        = "ssh"
    user        = "${module.core.username}"
    host        = "${module.core.floating_ip}"
    private_key = "${file("${var.private_key_path}")}"
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "${data.template_file.init_script.rendered}"
    ]
  }

  provisioner "local-exec" {
    command = "echo done >> ${var.trigger}"
  }

}
