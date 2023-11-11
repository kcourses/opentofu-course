# variables

variable "instance_name" {
  description = "Name of instance"
  type        = string
}

variable "instance_type" {
  description = "Type of instance"
  type        = string
  default     = "t3.micro"
}

variable "instance_bootstrap_script" {
  description = "Instance bootstrap script"
  type        = string
  default     = "ec2.sh"
}

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

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.app.id]

  user_data = file("${path.module}/bootstrap/${var.instance_bootstrap_script}")

  tags = {
    Name = var.instance_name
  }

  depends_on = [aws_security_group.app]
}