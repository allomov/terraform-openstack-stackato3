module "core" {
  source = "../../modules/stackato/primary"
  infrastructure = "${data.terraform_remote_state.infrastructure.state}"
  trigger = "${path.module}/triggers/core"
  # bastion        = "${data.terraform_remote_state.bastion.state}"
}

module "router" {
  roles          = ["router"]
  flavor         = "small"
  infrastructure = "${data.terraform_remote_state.infrastructure.state}"
  bastion        = "${data.terraform_remote_state.bastion.state}"
  core           = "${module.core.state}"
  source = "../../modules/stackato/secondary"
  trigger = "${path.module}/triggers/core"
}

module "dea" {
  roles          = ["dea"]
  flavor         = "large"
  infrastructure = "${data.terraform_remote_state.infrastructure.state}"
  bastion        = "${data.terraform_remote_state.bastion.state}"
  core           = "${module.core.state}"
  source = "../../modules/stackato/secondary"
  trigger = "${path.module}/triggers/core"
}
