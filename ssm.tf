# variables

variable "parameter_name" {
  description = "SSM parameter name"
  type        = string
}

variable "parameter_value" {
  description = "SSM parameter value"
  type        = string
}

variable "parameter_type" {
  description = "SSM parameter type"
  type        = string
  default     = "String"
}

variable "parameter_tags" {
  type = map(string)
  default = {
    Environment = "Production"
  }
}

variable "create_parameter" {
  type    = bool
  default = true
}

# resource

resource "aws_ssm_parameter" "this" {
  count = var.create_parameter ? 1 : 0

  name  = var.parameter_name
  type  = var.parameter_type
  value = var.parameter_value
  tags  = var.parameter_tags
}

resource "null_resource" "print" {
  provisioner "local-exec" {
    command     = "aws ssm get-parameter --name ${aws_ssm_parameter.this[0].name} --query Parameter.Value --output text > secret"
    interpreter = ["cmd.exe", "/C"]
  }

  depends_on = [aws_ssm_parameter.this[0]]
}

# outputs

output "parameter_name" {
  value = var.create_parameter ? aws_ssm_parameter.this[0].name : null
}

output "parameter_value" {
  value     = var.create_parameter ? aws_ssm_parameter.this[0].value : null
  sensitive = true
}