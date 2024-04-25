terraform {
  backend "s3" {
    bucket = "opentofu-course-release-state-bucket"
    key = "release/170/terraform.tfstate"
    region = "eu-west-1"
    encrypt = true
  }

  encryption {
    key_provider "aws_kms" "kms" {
      kms_key_id = "c1aa4deb-da4a-42c3-8b58-9f26ced1c081"
      region = "eu-west-1"
      key_spec = "AES_256"
    }

    method "aes_gcm" "my_method" {
      keys = key_provider.aws_kms.kms
    }

    ## Remove this after the migration:
    method "unencrypted" "migration" {
    }

    state {
      method = method.aes_gcm.my_method

      ## Remove the fallback block after migration:
      fallback{
        method = method.unencrypted.migration
      }
      ## Enable this after migration:
#      enforced = false
    }
  }
}