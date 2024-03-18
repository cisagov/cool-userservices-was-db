# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the additional permissions
# necessary to provision the WAS DB in the User Services account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionwasdb_policy_doc" {
  statement {
    actions = [
      "dynamodb:CreateTable",
      "dynamodb:DeleteTable",
      "dynamodb:DescribeContinuousBackups",
      "dynamodb:DescribeTable",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:ListTagsOfResource",
      "dynamodb:TagResource",
      "dynamodb:UntagResource",
      "dynamodb:UpdateContinuousBackups",
    ]

    resources = [
      "arn:aws:dynamodb:${var.aws_region}:${local.userservices_account_id}:table/${var.stakeholders_table_name}",
    ]
  }
}

resource "aws_iam_policy" "provisionwasdb_policy" {
  provider = aws.userservicesprovisionaccount

  description = var.provisionwasdb_policy_description
  name        = var.provisionwasdb_policy_name
  policy      = data.aws_iam_policy_document.provisionwasdb_policy_doc.json
}
