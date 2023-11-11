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

variable "instance_security_groups" {
  description = "Instance list of security groups"
  type = list(string)
  default = []
}