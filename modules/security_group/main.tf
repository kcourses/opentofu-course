resource "aws_security_group" "app" {
  name        = var.app_sg_name
  description = var.app_sg_description

  dynamic "ingress" {
    for_each = var.app_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = try(ingress.value.cidr_blocks, [])
      security_groups = try(ingress.value.security_groups, [])
    }
  }

  dynamic "egress" {
    for_each = var.app_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = try(egress.value.cidr_blocks, [])
      security_groups = try(egress.value.security_groups, [])
    }
  }
}