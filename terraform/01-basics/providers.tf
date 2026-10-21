provider "aws" {
  region = "ap-southeast-1"

  default_tags { # added to EVERY AWS resource this provider creates
    tags = local.common_tags
  }
}