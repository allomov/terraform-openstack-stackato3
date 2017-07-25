module "bastion" {
  source = "../../../modules/openstack/node"
}

resource "openstack_compute_instance_v2" "bastion" {

  depends_on = [
    "openstack_networking_router_interface_v2.interface_1"
  ]

  name              = "${var.prefix}_bastion"
  image_name        = "${var.image_name}"
  flavor_name       = "${var.flavor_name}"
  key_pair          = "${var.keypair}"

  network {
    name = "${var.network_name}"
  }

  security_groups = ["${formatlist(split(",", var.security_groups))}"]
}

resource "openstack_networking_floatingip_v2" "bastion" {
  pool = "admin_floating_net"
}

resource "openstack_compute_floatingip_associate_v2" "bastion_ip_associate" {
  floating_ip = "${openstack_networking_floatingip_v2.bastion.address}"
  instance_id = "${openstack_compute_instance_v2.bastion.id}"
}

# resource "openstack_networking_port_v2" "port_1" {
#   name           = "${var.prefix}_port_1"
#   network_id     = "${openstack_networking_network_v2.private_network.id}"
#   admin_state_up = "true"
# }

resource "null_resource" "bastion_provisioner" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    bastion_ip = "${openstack_compute_instance_v2.bastion.id}"
  }

  connection {
    type = "ssh"
    user = "${var.bastion_user}"
    host = "${openstack_networking_floatingip_v2.bastion.address}"
    private_key = "${file("${var.private_key_path}")}"
    timeout = "5m"
  }

  provisioner "file" {
    content     = "${file("${var.private_key_path}")}"
    destination = "/home/${var.bastion_user}/.ssh/id_rsa"
  }

  provisioner "file" {
    content     = "${file("${var.public_key_path}")}"
    destination = "/home/${var.bastion_user}/.ssh/id_rsa.pub"
  }

  provisioner "remote-exec" {
    script = "scripts/bastion.sh"
  }

  provisioner "file" {
    source      = "terraform.tfstate"
    destination = "/home/${var.bastion_user}/terraform-openstack-stackato3"
  }

  provisioner "file" {
    source      = "terraform.tfvars"
    destination = "/home/${var.bastion_user}/terraform-openstack-stackato3"
  }

  provisioner "file" {
    source      = "terraform.tfvars"
    destination = "/home/${var.bastion_user}/terraform-openstack-stackato3"
  }

}
