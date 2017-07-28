data "terraform_remote_state" "infrastructure" {
  backend = "local"

  config {
    path = "${path.module}/../infrastructure/terraform.tfstate"
  }
}

data "terraform_remote_state" "bastion" {
  backend = "local"

  config {
    path = "${path.module}/../bastion/terraform.tfstate"
  }
}
