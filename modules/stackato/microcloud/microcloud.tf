module "microcloud" {
  source = "../../openstack/node_with_floating_ip"
  name = "microcloud"

  image_name            = "${var.stackato_image_name}"
  flavor_name           = "${var.flavor_name}"
  floating_network_name = "${var.public_network_name}"
  private_network_name  = "${var.private_network_name}"
  key_pair_name         = "${var.key_pair_name}"
  
  username = "stackato"
  security_groups = ["${var.security_groups}"]
}

data "template_file" "domain" {
  template = "$${module.microcloud.floating_ip}.xip.io"

  vars {
    public_ip_address = "${module.microcloud.floating_ip}"
  }
}

resource "null_resource" "microcloud_provisioner" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    microcloud_ip = "${module.microcloud.id}"
  }

  connection {
    type = "ssh"
    user = "${module.microcloud.username}"
    host = "${module.microcloud.floating_ip}"
    private_key = "${file("${var.private_key_path}")}"
    timeout = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "kato node rename ${data.template_file.domain.rendered}"
    ]
  }
}
