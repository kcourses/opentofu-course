terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.1"
    }
  }

  backend "s3" {
    bucket         = "opentofu-course-state-bucket"
    key            = "web/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "opentofu-course-lock-table"
  }
}

provider "aws" {
  region = "eu-west-1"
}