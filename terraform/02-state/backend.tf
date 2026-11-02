terraform {
  backend "s3" {
    key = "02-state/terraform.tfstate"
  }
}