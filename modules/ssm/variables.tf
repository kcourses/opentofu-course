variable "parameter_name" {
  description = "SSM parameter name"
  type        = string
}

variable "parameter_value" {
  description = "SSM parameter value"
  type        = string
}

variable "parameter_type" {
  description = "SSM parameter type"
  type        = string
  default     = "String"
}

variable "parameter_tags" {
  type = map(string)
  default = {
    Environment = "Production"
  }
}

variable "create_parameter" {
  type    = bool
  default = true
}