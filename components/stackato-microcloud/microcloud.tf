data "terraform_remote_state" "infrastructure" {
  backend = "local"

  config {
    path = "${path.module}/../infrastructure/terraform.tfstate"
  }
}

module "microcloud" {
  source = "../../modules/stackato/microcloud"
  infrastructure = "${data.terraform_remote_state.infrastructure.state}"
}
