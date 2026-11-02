provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Lab       = "module-2-lab-6"
      ManagedBy = "Terraform"
    }
  }
}