# ------------------------------------------------------------------------------
# Retrieve the effective account ID, user ID, and ARN in which Terraform is
# authorized.  This is used to calculate the session names for assumed roles.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "current" {}

# ------------------------------------------------------------------------------
# Retrieve the caller identity for the User Services provider in order to get
# the associated account ID.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "userservices" {
  provider = aws.userservicesprovisionaccount
}

# ------------------------------------------------------------------------------
# Evaluate expressions for use throughout this configuration.
# ------------------------------------------------------------------------------
locals {
  # Extract the user name of the current caller for use as assume role session
  # names.
  caller_user_name = split("/", data.aws_caller_identity.current.arn)[1]

  # The User Services account ID
  userservices_account_id = data.aws_caller_identity.userservices.account_id
}
