output "instance_arn" {
  value = aws_instance.this.arn
}

output "instance_id" {
  value = aws_instance.this.id
}

output "instance_public_ip" {
  value = aws_instance.this.public_ip
}