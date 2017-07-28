module "core" {
  source = "../../modules/stackato/core"

  stackato_image_name   = "${data.terraform_remote_state.infrastructure.stackato_image_name}"
  flavor_name           = "${data.terraform_remote_state.infrastructure.medium_flavor_name}"
  public_network_name   = "${data.terraform_remote_state.infrastructure.public_network_name}"
  private_network_name  = "${data.terraform_remote_state.infrastructure.private_network_name}"
  key_pair_name         = "${data.terraform_remote_state.infrastructure.default_key_pair_name}"

  bastion_host = "${data.terraform_remote_state.bastion.}"
  bastion_user = "${data.terraform_remote_state.bastion.floatin_ip}"
  bastion_private_key = "${file(var.private_key_path)}"

  security_groups = [
    "${lookup(data.terraform_remote_state.infrastructure.security_groups, "http")}",
    "${lookup(data.terraform_remote_state.infrastructure.security_groups, "https")}",
    "${lookup(data.terraform_remote_state.infrastructure.security_groups, "private_network")}"
  ]
}

module "router" {
  source = "../../modules/stackato/router"

  stackato_image_name   = "${data.terraform_remote_state.infrastructure.stackato_image_name}"
  flavor_name           = "${data.terraform_remote_state.infrastructure.medium_flavor_name}"
  public_network_name   = "${data.terraform_remote_state.infrastructure.public_network_name}"
  private_network_name  = "${data.terraform_remote_state.infrastructure.private_network_name}"
  key_pair_name         = "${data.terraform_remote_state.infrastructure.default_key_pair_name}"

  bastion_host = "${data.terraform_remote_state.bastion.}"
  bastion_user = "${data.terraform_remote_state.bastion.floatin_ip}"
  bastion_private_key = "${file(var.private_key_path)}"

  security_groups = [
    "${lookup(data.terraform_remote_state.infrastructure.security_groups, "http")}",
    "${lookup(data.terraform_remote_state.infrastructure.security_groups, "https")}",
    "${lookup(data.terraform_remote_state.infrastructure.security_groups, "private_network")}"
  ]
}

module "dea" {
  source = "../../modules/stackato/dea"

  stackato_image_name   = "${data.terraform_remote_state.infrastructure.stackato_image_name}"
  flavor_name           = "${data.terraform_remote_state.infrastructure.medium_flavor_name}"
  public_network_name   = "${data.terraform_remote_state.infrastructure.public_network_name}"
  private_network_name  = "${data.terraform_remote_state.infrastructure.private_network_name}"
  key_pair_name         = "${data.terraform_remote_state.infrastructure.default_key_pair_name}"

  bastion_host = "${data.terraform_remote_state.bastion.}"
  bastion_user = "${data.terraform_remote_state.bastion.floatin_ip}"
  bastion_private_key = "${file(var.private_key_path)}"

  security_groups = [
    "${lookup(data.terraform_remote_state.infrastructure.security_groups, "private_network")}"
  ]
}
