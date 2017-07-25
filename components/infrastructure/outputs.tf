output "private_network_name" { value = "${openstack_networking_network_v2.private_network.name}" }
output "private_network_id"   { value = "${openstack_networking_network_v2.private_network.id}" }
output "public_network_name"  { value = "${var.openstack_public_network_name}" }
output "public_network_id"    { value = "${var.openstack_public_network_id}" }

output "security_groups" {
  value = "${
    map(
      "ssh",             "${openstack_compute_secgroup_v2.ssh.name}",
      "http",            "${openstack_compute_secgroup_v2.http.name}",
      "https",           "${openstack_compute_secgroup_v2.https.name}",
      "private_network", "${openstack_compute_secgroup_v2.private_network.name}"
    )
  }"
}

output "default_key_pair_name" { value = "${openstack_compute_keypair_v2.default_key_pair.name}" }

output "stackato_image_name"   { value = "${openstack_images_image_v2.stackato_image.name}" }
output "bastion_image_name"   { value = "${openstack_images_image_v2.bastion_image.name}" }

output "default_flavor_name" { value = "${var.default_flavor_name}" }
output "small_flavor_name"   { value = "${var.small_flavor_name}" }
output "large_flavor_name"   { value = "${var.large_flavor_name}" }
output "medium_flavor_name"  { value = "${var.medium_flavor_name}" }
