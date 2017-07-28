resource "openstack_compute_instance_v2" "node" {
  name              = "${lookup(var.infrastructure, "prefix")}-${var.vm_name}"
  image_name        = "${var.image_name}"
  flavor_name       = "${var.flavor_name}"
  security_groups   = ["${var.security_groups}"]
  key_pair          = "${lookup(var.infrastructure, "default_key_pair_name")}"

  network {
    name = "${lookup(var.infrastructure, "private_network_name")}"
  }
}

resource "openstack_networking_floatingip_v2" "node" {
  pool = "${lookup(var.infrastructure, "public_network_name")}"
}

resource "openstack_compute_floatingip_associate_v2" "node_ip_associate" {
  floating_ip = "${openstack_networking_floatingip_v2.node.address}"
  instance_id = "${openstack_compute_instance_v2.node.id}"
}
