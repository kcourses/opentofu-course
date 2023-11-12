module "web_security_group" {
  source = "./modules/security_group"

  app_sg_name        = "web"
  app_sg_description = "Default WEB SG description"

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

module "web_ec2_instance" {
  source = "./modules/ec2"

  instance_name = "web"
  instance_security_groups = [module.web_security_group.app_security_group_id]

  message = "WEB"

  depends_on = [module.web_security_group]
}

module "web_ssm_parameter" {
  source = "./modules/ssm"

  parameter_name = "/setup/web/instance"
  parameter_value = module.web_ec2_instance.instance_public_ip
  parameter_type = "String"
  parameter_tags = {
    "Environment" = "Development"
  }
  parameter_out_file = "web"

  depends_on = [
    module.web_security_group,
    module.web_ec2_instance,
  ]
}

output "web_instance_id" {
  value = module.web_ec2_instance.instance_id
}

output "web_instance_arn" {
  value = module.web_ec2_instance.instance_arn
}

output "web_parameter_value" {
  value = module.web_ssm_parameter.parameter_value
  sensitive = true
}