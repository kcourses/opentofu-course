variable "db_allocated_storage" {
  type = number
  default = 10
}

variable "db_db_name" {
  type = string
  default = "mydb"
}

variable "db_engine" {
  type = string
  default = "mysql"
}

variable "db_engine_version" {
  type = string
  default = "5.7"
}

variable "db_instance_class" {
  type = string
  default = "db.t3.micro"
}

variable "db_username" {
  type = string
  default = "testuser"
}

variable "db_password" {
  type = string
  default = "testpass"
}

variable "db_parameter_group_name" {
  type = string
  default = "default.mysql5.7"
}

variable "db_skip_final_snapshot" {
  type = bool
  default = true
}

variable "db_security_groups" {
  type = list(string)
  default = []
}