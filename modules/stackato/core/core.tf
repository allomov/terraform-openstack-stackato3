module "microcloud" {
  source = "../../openstack/node_with_floating_ip"
  vm_name     = "${var.vm_name}"
  image_name  = "${lookup(var.infrastructure, "stackato_image_name")}"
  flavor_name = "${lookup(var.infrastructure, "large_flavor_name")}"
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
    public_ip_address = "${module.microcloud.floating_ip}"
  }
}

data "template_file" "init_script" {
  template = "${file("${path.module}/scripts/microcloud.sh.tpl")}"
  vars {
    domain = "${data.template_file.domain.rendered}"
  }
}

resource "null_resource" "microcloud_provisioner" {
  # Changes to any instance of the cluster requires re-provisioning
  depends_on = [ "module.microcloud" ]
  triggers {
    microcloud_ip = "${module.microcloud.id}"
  }

  connection {
    type        = "ssh"
    user        = "${module.microcloud.username}"
    host        = "${module.microcloud.floating_ip}"
    private_key = "${file("${var.private_key_path}")}"
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "${data.template_file.init_script.rendered}"
    ]
  }
}
