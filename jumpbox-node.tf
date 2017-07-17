data "openstack_images_image_v2" "jumpbox_image" {
  name = "${var.jumpbox_image_name}"
  most_recent = true
}

resource "openstack_compute_keypair_v2" "default_keypair" {
  name       = "${var.key_pair_name}"
  public_key = "${file("${var.public_key_path}")}"
}

resource "openstack_compute_instance_v2" "jumpbox" {

  depends_on = [
    "openstack_networking_router_interface_v2.interface_1"
  ]

  name              = "${var.prefix}_jumpbox"
  image_name        = "${var.jumpbox_image_name}"
  flavor_name       = "${var.small_flavor_name}"
  key_pair          = "${openstack_compute_keypair_v2.default_keypair.name}"

  network {
    name = "${openstack_networking_network_v2.private_network.name}"
  }

  security_groups = [
      "${openstack_compute_secgroup_v2.ssh.name}"
  ]
}

resource "openstack_compute_floatingip_associate_v2" "jumpbox_ip_associate" {
  floating_ip = "${openstack_networking_floatingip_v2.jumpbox.address}"
  instance_id = "${openstack_compute_instance_v2.jumpbox.id}"
}

# resource "openstack_networking_port_v2" "port_1" {
#   name           = "${var.prefix}_port_1"
#   network_id     = "${openstack_networking_network_v2.private_network.id}"
#   admin_state_up = "true"
# }

resource "null_resource" "jumpbox_provisioner" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    jumpbox_ip = "${openstack_compute_instance_v2.jumpbox.id}"
  }

  connection {
    type = "ssh"
    user = "${var.jumpbox_user}"
    host = "${openstack_networking_floatingip_v2.jumpbox.address}"
    private_key = "${file("${var.private_key_path}")}"
    timeout = "5m"
  }

  provisioner "file" {
    content     = "${file("${var.private_key_path}")}"
    destination = "/home/${var.jumpbox_user}/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    script = "scripts/jumpbox.sh"
  }

}
