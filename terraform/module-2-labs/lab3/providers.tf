provider "aws" {
  region = var.aws_region
  default_tags { # added to EVERY AWS resource this provider creates
    tags = local.common_tags
  }
}