output "database_endpoint" {
  value = aws_db_instance.main.endpoint
}

output "database_address" {
  value = aws_db_instance.main.address
}