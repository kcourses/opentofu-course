module "live_security_group" {
  source = "D:/GolangProjects/opentofu-course/modules/security_group"

  app_sg_name        = "live"
  app_sg_description = "Default LIVE SG description"

  app_ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  app_egress_rules = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "live_ec2_instance" {
  source = "D:/GolangProjects/opentofu-course/modules/ec2"

  instance_name            = "live"
  instance_security_groups = [module.live_security_group.app_security_group_id]

  message = "LIVE"

  depends_on = [module.live_security_group]
}

module "live_ssm_parameter" {
  source = "D:/GolangProjects/opentofu-course/modules/ssm"

  parameter_name  = "/setup/live/instance"
  parameter_value = module.live_ec2_instance.instance_public_ip
  parameter_type  = "String"
  parameter_tags = {
    "Environment" = "Production"
  }
  parameter_out_file = "live"

  depends_on = [
    module.live_security_group,
    module.live_ec2_instance,
  ]
}

output "live_instance_id" {
  value = module.live_ec2_instance.instance_id
}

output "live_instance_arn" {
  value = module.live_ec2_instance.instance_arn
}

output "live_parameter_value" {
  value     = module.live_ssm_parameter.parameter_value
  sensitive = true
}