
resource "openstack_compute_instance_v2" "node" {
  name              = "${var.name}"
  image_name        = "${var.image_name}"
  flavor_name       = "${var.flavor_name}"
  key_pair          = "${var.key_pair_name}"
  network {
    name = "${var.private_network_name}"
  }

  security_groups = ["${var.security_groups}"]
}

resource "openstack_networking_floatingip_v2" "node" {
  pool = "${var.floating_network_name}"
}

resource "openstack_compute_floatingip_associate_v2" "node_ip_associate" {
  floating_ip = "${openstack_networking_floatingip_v2.node.address}"
  instance_id = "${openstack_compute_instance_v2.node.id}"
}
