# ------------------------------------------------------------------------------
# Create the IAM policy and role that allow read-only access to the WAS DB in
# the User Services account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "read_only_doc" {
  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:ConditionCheckItem",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
    ]

    resources = [
      aws_dynamodb_table.was.arn,
    ]
  }

  # Allow the user to list all DynamoDB tables so that they can find and select
  # the WAS DB when using the AWS web console.
  statement {
    actions = [
      "dynamodb:ListTables",
    ]

    resources = [
      replace(aws_dynamodb_table.was.arn, "table/${aws_dynamodb_table.was.name}", "table/*"),
    ]
  }

  # Allow the user to view metrics for the WAS DynamoDB table.  I have not yet
  # found a way to limit this access to only the WAS table.
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
resource "aws_iam_policy" "read_only" {
  provider = aws.userservicesprovisionaccount

  description = var.read_only_policy_role_description
  name        = var.read_only_policy_role_name
  policy      = data.aws_iam_policy_document.read_only_doc.json
}

# Create the IAM role
resource "aws_iam_role" "read_only" {
  provider = aws.userservicesprovisionaccount

  assume_role_policy = data.aws_iam_policy_document.users_account_assume_role_doc.json
  description        = var.read_only_policy_role_description
  name               = var.read_only_policy_role_name
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "read_only" {
  provider = aws.userservicesprovisionaccount

  policy_arn = aws_iam_policy.read_only.arn
  role       = aws_iam_role.read_only.name
}