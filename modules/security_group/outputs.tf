output "app_security_group_id" {
  value = aws_security_group.app.id
}

output "app_security_group_ingress_rules" {
  value = aws_security_group.app.ingress
}

output "app_security_group_egress_rules" {
  value = aws_security_group.app.egress
}