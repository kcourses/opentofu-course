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
}