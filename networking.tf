
resource "openstack_networking_network_v2" "private_network" {
    name = "${var.prefix}_private_network"
    admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
    name = "${var.prefix}_subnet"
    network_id = "${openstack_networking_network_v2.private_network.id}"
    cidr = "${var.network}.0.0/16"
    ip_version = 4
    dns_nameservers = [ "8.8.8.8" ]
}

resource "openstack_networking_router_v2" "router_1" {
  name = "${var.prefix}_router"
  admin_state_up = "true"
  region = "${var.openstack_region}"
  external_gateway = "${var.openstack_public_network_id}"
}

resource "openstack_networking_router_interface_v2" "interface_1" {
    subnet_id = "${openstack_networking_subnet_v2.subnet_1.id}"
    router_id = "${openstack_networking_router_v2.router_1.id}"
}

resource "openstack_networking_floatingip_v2" "jumpbox" {
  pool = "admin_floating_net"
}
