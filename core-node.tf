resource "openstack_compute_instance_v2" "core_node" {

  depends_on = [
    "openstack_networking_router_interface_v2.interface_1"
  ]

  name              = "${var.prefix}_core_node"
  image_id          = "${openstack_images_image_v2.stackato362.id}"
  flavor_name       = "${var.default_flavor_name}"
  key_pair          = "${openstack_compute_keypair_v2.default_keypair.name}"

  network {
    name = "${openstack_networking_network_v2.private_network.name}"
  }

  security_groups = [
      "${openstack_compute_secgroup_v2.ssh.name}",
      "${openstack_compute_secgroup_v2.http.name}",
      "${openstack_compute_secgroup_v2.https.name}"
  ]

}

resource "openstack_networking_floatingip_v2" "core_node" {
  pool = "admin_floating_net"
}

resource "openstack_compute_floatingip_associate_v2" "core_node_ip_associate" {
  floating_ip = "${openstack_networking_floatingip_v2.core_node.address}"
  instance_id = "${openstack_compute_instance_v2.core_node.id}"
}

# resource "openstack_networking_port_v2" "port_1" {
#   name           = "${var.prefix}_port_1"
#   network_id     = "${openstack_networking_network_v2.private_network.id}"
#   admin_state_up = "true"
# }

resource "null_resource" "core_node_provisioner" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    jumpbox_ip = "${openstack_compute_instance_v2.core_node.id}"
  }

  connection {
    type = "ssh"
    user = "stackato"
    host = "${openstack_networking_floatingip_v2.core_node.address}"
    private_key = "${file("/home/${var.jumpbox_user}/.ssh/id_rsa")}"
    timeout = "5m"
  }

  provisioner "remote-exec" {
    script = "scripts/jumpbox.sh"
  }

}
