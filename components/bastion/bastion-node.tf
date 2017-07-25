data "terraform_remote_state" "infrastructure" {
  backend = "local"

  config {
    path = "${path.module}/../infrastructure/terraform.tfstate"
  }
}

# terraform {
#   backend "local" {
#     path = "../terraform.tfstate"
#   }
# }

module "bastion" {
  source = "../../modules/openstack/node_with_floaring_ip"
  name = "bastion"

  security_groups = [
    "${lookup(data.terraform_remote_state.infrastructure.security_groups, "ssh")}",
    "${lookup(data.terraform_remote_state.infrastructure.security_groups, "private_network")}"
  ]

  image_name            = "${data.terraform_remote_state.infrastructure.bastion_image_name}"
  flavor_name           = "${var.small_flavor_name}"
  floating_network_name = "${var.openstack_public_network_name}"
  private_network_name  = "${data.terraform_remote_state.infrastructure.private_network_name}"
  key_pair_name         = "${data.terraform_remote_state.infrastructure.default_key_pair_name}"
  username = "ubuntu"
  # network_name          = "${openstack_networking_network_v2.private_network.name}"
}

resource "null_resource" "bastion_provisioner" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    bastion_ip = "${module.bastion.id}"
  }

  connection {
    type = "ssh"
    user = "${module.bastion.username}"
    host = "${module.bastion.floating_ip}"
    private_key = "${file("${var.private_key_path}")}"
    timeout = "5m"
  }

  provisioner "file" {
    content     = "${file("${var.private_key_path}")}"
    destination = "/home/${module.bastion.username}/.ssh/id_rsa"
  }

  provisioner "file" {
    content     = "${file("${var.public_key_path}")}"
    destination = "/home/${module.bastion.username}/.ssh/id_rsa.pub"
  }

  provisioner "remote-exec" {
    script = "./scripts/bastion.sh"
  }

  provisioner "file" {
    source      = "terraform.tfstate"
    destination = "/home/${module.bastion.username}/terraform-openstack-stackato3"
  }

  provisioner "file" {
    source      = "terraform.tfvars"
    destination = "/home/${module.bastion.username}/terraform-openstack-stackato3"
  }

  provisioner "file" {
    source      = "terraform.tfvars"
    destination = "/home/${module.bastion.username}/terraform-openstack-stackato3"
  }

}
