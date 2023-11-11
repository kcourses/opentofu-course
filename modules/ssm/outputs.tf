output "parameter_name" {
  value = var.create_parameter ? aws_ssm_parameter.this[0].name : null
}

output "parameter_value" {
  value     = var.create_parameter ? aws_ssm_parameter.this[0].value : null
  sensitive = true
}