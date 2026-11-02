provider "aws" {
  region = local.default_region
  default_tags {
    tags = local.default_tags
  }
}