locals {
  backend_data = yamldecode(file(find_in_parent_folders("backend.yaml")))
  environment_data = yamldecode(file("environment.yaml"))
}

inputs = merge(
    local.backend_data,
    local.environment_data
)

terraform {
  source = "../../application"

  before_hook "notification" {
    commands = ["apply", "plan"]
    execute = ["cmd", "/C", "echo", "Running application on ${local.environment_data["region"]} region."]
  }
}

generate "providers" {
  path = "providers.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  region = "${local.environment_data["region"]}"
}
EOF
}

remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket = local.backend_data["state_bucket_name"]
    key = "${local.environment_data["region"]}/terraform.tfstate"
    region = local.backend_data["backend_region"]
    encrypt = true
    dynamodb_table = local.backend_data["lock_table_name"]
  }
}