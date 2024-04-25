terraform {
  required_providers {
    corefunc = {
      source = "northwood-labs/corefunc"
      version = "1.4.0"
    }
  }
}

provider "corefunc" {
}

output "test" {
  value = provider::corefunc::str_camel("Hello world!")
# Prints: hello_world
}