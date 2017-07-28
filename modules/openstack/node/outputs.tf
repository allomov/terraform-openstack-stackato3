output "id" { value = "${openstack_compute_instance_v2.node.id}" }
output "private_ip" { value = "${openstack_compute_instance_v2.node.network.0.fixed_ip_v4}" }
output "username" { value = "${var.username}" }

output "state" {
  value = "${
    map(
      "id", "${openstack_compute_instance_v2.node.id}",
      "private_ip", "${openstack_compute_instance_v2.node.network.0.fixed_ip_v4}",
      "username", "${var.username}",
    )
  }"
}
