# The DynamoDB table used to store WAS (Web Application Scanning) data.
#
# If the sort (range) key variable is empty, then the table is created with only
# a partition (hash) key.  Otherwise, the table is created with both a partition
# key and a sort key.

resource "aws_dynamodb_table" "stakeholders_without_sort_key" {
  # Sort key is absent, so create the table without it
  count      = var.stakeholders_table_sort_key == "" ? 1 : 0
  depends_on = [aws_iam_role_policy_attachment.provisionwasdb_policy_attachment]
  provider   = aws.userservicesprovisionaccount

  hash_key       = var.stakeholders_table_partition_key
  name           = var.stakeholders_table_name
  read_capacity  = var.stakeholders_table_read_capacity
  write_capacity = var.stakeholders_table_write_capacity

  attribute {
    name = var.stakeholders_table_partition_key
    type = var.stakeholders_table_partition_key_type
  }

  point_in_time_recovery {
    enabled = var.stakeholders_table_point_in_time_recovery
  }
}

resource "aws_dynamodb_table" "stakeholders_with_sort_key" {
  # Sort key is present, so create the table with it
  count      = var.stakeholders_table_sort_key == "" ? 0 : 1
  depends_on = [aws_iam_role_policy_attachment.provisionwasdb_policy_attachment]
  provider   = aws.userservicesprovisionaccount

  hash_key       = var.stakeholders_table_partition_key
  name           = var.stakeholders_table_name
  range_key      = var.stakeholders_table_sort_key
  read_capacity  = var.stakeholders_table_read_capacity
  write_capacity = var.stakeholders_table_write_capacity

  attribute {
    name = var.stakeholders_table_partition_key
    type = var.stakeholders_table_partition_key_type
  }

  attribute {
    name = var.stakeholders_table_sort_key
    type = var.stakeholders_table_sort_key_type
  }

  point_in_time_recovery {
    enabled = var.stakeholders_table_point_in_time_recovery
  }
}
