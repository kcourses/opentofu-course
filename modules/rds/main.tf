resource "aws_db_instance" "this" {
  allocated_storage    = var.db_allocated_storage
  db_name              = var.db_db_name
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = var.db_parameter_group_name
  skip_final_snapshot  = var.db_skip_final_snapshot
  vpc_security_group_ids = var.db_security_groups
}