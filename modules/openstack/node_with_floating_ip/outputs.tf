output "id" { value = "${openstack_compute_instance_v2.node.id}" }
output "private_ip" { value = "${openstack_compute_instance_v2.node.network.0.fixed_ip_v4}" }
output "floating_ip" { value = "${openstack_networking_floatingip_v2.node.address}" }
output "username" { value = "${var.username}" }

output "state" {
  value = "${
    map(
      "id", "${openstack_compute_instance_v2.node.id}",
      "private_ip", "${openstack_compute_instance_v2.node.network.0.fixed_ip_v4}",
      "floating_ip", "${openstack_networking_floatingip_v2.node.address}",
      "username", "${var.username}",
    )
  }"
}
