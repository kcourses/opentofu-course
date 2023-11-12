data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "bootstrap_data_script" {
  template = file("${path.module}/bootstrap/${var.instance_bootstrap_script}")

  vars = {
    message = var.message
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = var.instance_security_groups

  user_data = data.template_file.bootstrap_data_script.rendered
#  user_data = file("${path.module}/bootstrap/${var.instance_bootstrap_script}")

  tags = {
    Name = var.instance_name
  }
}