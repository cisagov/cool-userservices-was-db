output "read_only_role" {
  description = "The WAS database read-only role."
  value       = aws_iam_role.read_only
}

output "read_write_role" {
  description = "The WAS database read-write role."
  value       = aws_iam_role.read_write
}

output "reports_table" {
  description = "The WAS reports DynamoDB table."
  value       = var.reports_table_sort_key == "" ? aws_dynamodb_table.reports_without_sort_key[0] : aws_dynamodb_table.reports_with_sort_key[0]
}

output "stakeholders_table" {
  description = "The WAS stakeholders DynamoDB table."
  value       = var.stakeholders_table_sort_key == "" ? aws_dynamodb_table.stakeholders_without_sort_key[0] : aws_dynamodb_table.stakeholders_with_sort_key[0]
}
