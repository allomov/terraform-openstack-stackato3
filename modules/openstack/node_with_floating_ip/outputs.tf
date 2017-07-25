output "id" {
  value = "${openstack_compute_instance_v2.node.id}"
}

output "private_ip" {
  value = "${openstack_compute_instance_v2.node.address}"
}

output "floating_ip" {
  value = "${openstack_networking_floatingip_v2.node.address}"
}

output "username" {
  value = "${var.username}"
}
