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

# resource

resource "aws_ssm_parameter" "this" {
  name  = var.parameter_name
  type  = var.parameter_type
  value = var.parameter_value
  tags  = var.parameter_tags
}

# outputs

output "parameter_name" {
  value = aws_ssm_parameter.this.name
}

output "parameter_value" {
  value = aws_ssm_parameter.this.value
  sensitive = true
}