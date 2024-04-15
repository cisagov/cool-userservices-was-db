# The DynamoDB table used to store WAS (Web Application Scanning) report data.
#
# If the sort (range) key variable is empty, then the table is created with only
# a partition (hash) key.  Otherwise, the table is created with both a partition
# key and a sort key.

resource "aws_dynamodb_table" "reports" {
  depends_on = [aws_iam_role_policy_attachment.provisionwasdb_policy_attachment]
  provider   = aws.userservicesprovisionaccount

  hash_key       = var.reports_table_partition_key
  name           = var.reports_table_name
  range_key      = var.reports_table_sort_key
  read_capacity  = var.reports_table_read_capacity
  write_capacity = var.reports_table_write_capacity

  dynamic "attribute" {
    for_each = local.reports_table_attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  point_in_time_recovery {
    enabled = var.reports_table_point_in_time_recovery
  }
}
