output "read_only_role" {
  description = "The WAS database read-only role."
  value       = aws_iam_role.read_only
}

output "read_write_role" {
  description = "The WAS database read-write role."
  value       = aws_iam_role.read_write
}

output "was_db_table" {
  description = "The WAS database table."
  value       = aws_dynamodb_table.was
}
