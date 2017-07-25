provider "openstack" {
    auth_url = "${var.openstack_identity_endpoint}"
    tenant_name = "${var.openstack_tenant_name}"
    user_name = "${var.openstack_username}"
    password = "${var.openstack_password}"
    domain_name = "${var.openstack_domain_name}"
}
