resource "openstack_compute_secgroup_v2" "ssh" {
  name = "public-ssh"
  description = "Security group for instances that will have public SSH access"
  region = "${var.openstack_region}"
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
}

# TODO: move from ::/0 to subnets into security groups
# TODO: add BOSH from_group_id
resource "openstack_compute_secgroup_v2" "bosh" {
  name = "bosh"
  description = "BOSH Security group."
  region = "${var.openstack_region}"

  # rule {
  #   from_port = 1
  #   to_port = 65535
  #   ip_protocol = "tcp"
  #   from_group_id = "${openstack_compute_secgroup_v2.bosh.id}"
  # }

  rule {
    from_port = 25777
    to_port = 25777
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 25555
    to_port = 25555
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }

  rule {
    from_port = 25250
    to_port = 25250
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 6868
    to_port = 6868
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 4222
    to_port = 4222
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }

  rule {
    from_port = 53
    to_port = 53
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 53
    to_port = 53
    ip_protocol = "udp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 68
    to_port = 68
    ip_protocol = "udp"
    cidr = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "cf-public" {
  name = "cf-public"
  description = "Security group for instances that will have public SSH access"
  region = "${var.openstack_region}"
  rule {
    from_port = 443
    to_port = 443
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 68
    to_port = 68
    ip_protocol = "udp"
    cidr = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "cf-private" {
  name = "cf-private"
  description = "Security group for instances that will have public SSH access"
  region = "${var.openstack_region}"
  rule {
    from_port = 68
    to_port = 68
    ip_protocol = "udp"
    cidr = "0.0.0.0/0"
  }
}
