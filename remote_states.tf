# ------------------------------------------------------------------------------
# Retrieves state data from a Terraform backend. This allows use of the
# root-level outputs of one or more Terraform configurations as input data
# for this configuration.
# ------------------------------------------------------------------------------

data "terraform_remote_state" "master" {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    profile        = "cool-terraform-backend"
    region         = "us-east-1"
    key            = "cool-accounts/master.tfstate"
  }

  # There is only one environment for this account, so there is
  # no need to match the current Terraform workspace.
  workspace = "production"
}

data "terraform_remote_state" "userservices" {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    profile        = "cool-terraform-backend"
    region         = "us-east-1"
    key            = "cool-accounts-userservices/terraform.tfstate"
  }

  # We typically use data from this remote state to determine if the User
  # Services account is in staging or production, but since we need to specify
  # the correct workspace below in order to define this remote state, we must
  # instead rely on the name of our current Terraform workspace; it must match
  # the name of one of the workspaces in cool-accounts-userservices (e.g.
  # staging, production).
  workspace = terraform.workspace
}
