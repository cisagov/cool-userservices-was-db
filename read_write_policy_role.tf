# ------------------------------------------------------------------------------
# Create the IAM policy and role that allow read-write access to the WAS
# DynamoDB tables in the User Services account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "read_write_doc" {
  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:ConditionCheckItem",
      "dynamodb:DeleteItem",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:UpdateItem",
    ]

    resources = [
      local.reports_table_arn,
      local.stakeholders_table_arn,
    ]
  }

  # Allow the user to list all DynamoDB tables so that they can find and select
  # the WAS DynamoDB tables when using the AWS web console.
  statement {
    actions = [
      "dynamodb:ListTables",
    ]

    # Since we are allowing the user to list all DynamoDB tables, we only need
    # to choose one of our tables to use as the basis for this resource.
    resources = [
      replace(local.stakeholders_table_arn, "table/${var.stakeholders_table_name}", "table/*"),
    ]
  }

  # Allow the user to view metrics for the WAS DynamoDB tables.  I have not yet
  # found a way to limit this access to only the WAS tables.
  statement {
    actions = [
      "logs:DescribeMetricFilters",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
    ]

    resources = [
      "*",
    ]
  }
}

# Create the IAM policy
resource "aws_iam_policy" "read_write" {
  provider = aws.userservicesprovisionaccount

  description = var.read_write_policy_role_description
  name        = var.read_write_policy_role_name
  policy      = data.aws_iam_policy_document.read_write_doc.json
}

# Create the IAM role
resource "aws_iam_role" "read_write" {
  provider = aws.userservicesprovisionaccount

  assume_role_policy = data.aws_iam_policy_document.users_account_assume_role_doc.json
  description        = var.read_write_policy_role_description
  name               = var.read_write_policy_role_name
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "read_write" {
  provider = aws.userservicesprovisionaccount

  policy_arn = aws_iam_policy.read_write.arn
  role       = aws_iam_role.read_write.name
}
