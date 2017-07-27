data "terraform_remote_state" "infrastructure" {
  backend = "local"

  config {
    path = "${path.module}/../infrastructure/terraform.tfstate"
  }
}

module "microcloud" {
  source = "../../modules/stackato/microcloud"

  stackato_image_name   = "${data.terraform_remote_state.infrastructure.stackato_image_name}"
  flavor_name           = "${data.terraform_remote_state.infrastructure.medium_flavor_name}"
  public_network_name   = "${data.terraform_remote_state.infrastructure.public_network_name}"
  private_network_name  = "${data.terraform_remote_state.infrastructure.private_network_name}"
  key_pair_name         = "${data.terraform_remote_state.infrastructure.default_key_pair_name}"

  security_groups = [
    "${lookup(data.terraform_remote_state.infrastructure.security_groups, "ssh")}",
    "${lookup(data.terraform_remote_state.infrastructure.security_groups, "http")}",
    "${lookup(data.terraform_remote_state.infrastructure.security_groups, "https")}",
    "${lookup(data.terraform_remote_state.infrastructure.security_groups, "private_network")}"
  ]
}

# resource "null_resource" "microcloud_provisioner" {
#   # Changes to any instance of the cluster requires re-provisioning
#   triggers {
#     microcloud_ip = "${module.microcloud.id}"
#   }

#   connection {
#     type = "ssh"
#     user = "${module.microcloud.username}"
#     host = "${module.microcloud.floating_ip}"
#     private_key = "${file("${var.private_key_path}")}"
#     timeout = "5m"
#   }

#   provisioner "remote-exec" {
#     script = "./scripts/microcloud.sh"
#   }

# }
