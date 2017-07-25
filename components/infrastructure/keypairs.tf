resource "openstack_compute_keypair_v2" "default_key_pair" {
  name       = "${var.key_pair_name}"
  public_key = "${file("${var.public_key_path}")}"
}
