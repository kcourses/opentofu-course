output "rds_arn" {
  value = aws_db_instance.this.arn
}

output "rds_id" {
  value = aws_db_instance.this.id
}