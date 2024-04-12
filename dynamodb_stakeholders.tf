# The DynamoDB table used to store WAS (Web Application Scanning) stakeholder
# data.
#
# If the sort (range) key variable is empty, then the table is created with only
# a partition (hash) key.  Otherwise, the table is created with both a partition
# key and a sort key.

resource "aws_dynamodb_table" "stakeholders" {
  depends_on = [aws_iam_role_policy_attachment.provisionwasdb_policy_attachment]
  provider   = aws.userservicesprovisionaccount

  hash_key       = var.stakeholders_table_partition_key
  name           = var.stakeholders_table_name
  range_key      = var.stakeholders_table_sort_key
  read_capacity  = var.stakeholders_table_read_capacity
  write_capacity = var.stakeholders_table_write_capacity

  dynamic "attribute" {
    for_each = local.stakeholders_table_attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  point_in_time_recovery {
    enabled = var.stakeholders_table_point_in_time_recovery
  }
}
