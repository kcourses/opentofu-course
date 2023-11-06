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

resource "null_resource" "print" {
  provisioner "local-exec" {
    command = "aws ssm get-parameter --name ${aws_ssm_parameter.this.name} --query Parameter.Value --output text > secret"
    interpreter = ["cmd.exe", "/C"]
  }

  depends_on = [aws_ssm_parameter.this]
}

# outputs

output "parameter_name" {
  value = aws_ssm_parameter.this.name
}

output "parameter_value" {
  value = aws_ssm_parameter.this.value
  sensitive = true
}