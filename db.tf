module "db_security_group" {
  source = "./modules/security_group"

  app_sg_name        = "db"
  app_sg_description = "Default DB SG description"

  app_ingress_rules = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      security_groups = [
        module.web_security_group.app_security_group_id,
        module.live_security_group.app_security_group_id,
      ]
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

module "db_instance" {
  source = "./modules/rds"
  db_security_groups = [module.db_security_group.app_security_group_id]
  depends_on = [module.db_security_group]
}

output "db_rds_id" {
  value = module.db_instance.rds_id
}

output "db_rds_arn" {
  value = module.db_instance.rds_arn
}