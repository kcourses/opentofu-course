# variables

variable "app_sg_name" {
  type        = string
  description = "Name of App SG"
}

variable "app_sg_description" {
  type        = string
  description = "Description of App SG"
}

variable "app_ingress_rules" {
  description = "List of ingress rules of APP SG"
  type        = list(any)
}

variable "app_egress_rules" {
  description = "List of egress rules of APP SG"
  type        = list(any)
}

# resource

resource "aws_security_group" "app" {
  name        = var.app_sg_name
  description = var.app_sg_description

  dynamic "ingress" {
    for_each = var.app_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.app_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

# outputs

output "app_security_group_id" {
  value = aws_security_group.app.id
}

output "app_security_group_ingress_rules" {
  value = aws_security_group.app.ingress
}

output "app_security_group_egress_rules" {
  value = aws_security_group.app.egress
}