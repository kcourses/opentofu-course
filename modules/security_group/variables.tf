variable "app_sg_name" {
  type        = string
  description = "Name of App SG"
}

variable "app_sg_description" {
  type        = string
  description = "Description of App SG"
}

variable "app_ingress_rules" {
  description = "List of ingress rules of APP SG"
  type        = list(any)
}

variable "app_egress_rules" {
  description = "List of egress rules of APP SG"
  type        = list(any)
}