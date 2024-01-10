# The DynamoDB table used to store WAS (Web Application Scanning) data

resource "aws_dynamodb_table" "was" {
  depends_on = [aws_iam_role_policy_attachment.provisionwasdb_policy_attachment]
  provider   = aws.userservicesprovisionaccount

  hash_key       = var.partition_key
  name           = var.table_name
  range_key      = var.sort_key
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  attribute {
    name = var.partition_key
    type = var.partition_key_type
  }

  attribute {
    name = var.sort_key
    type = var.sort_key_type
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }
}
