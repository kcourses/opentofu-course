data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

variable "instance_tags" {
  type = list(string)
  default = ["web", "app"]
}

variable "instance_ids" {
  type = list(string)
  default = ["i-0d668082e6df61352", "i-0c85c78b4c3544dc0"]
}

resource "aws_instance" "this" {
  count = length(var.instance_tags)

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = var.instance_tags[count.index]
  }
}

import {
  for_each = { for idx, item in var.instance_ids : idx => item}
  to = aws_instance.this[tonumber(each.key)]
  id = each.value
}