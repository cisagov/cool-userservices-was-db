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
  value       = aws_dynamodb_table.reports
}

output "stakeholders_table" {
  description = "The WAS stakeholders DynamoDB table."
  value       = aws_dynamodb_table.stakeholders
}
