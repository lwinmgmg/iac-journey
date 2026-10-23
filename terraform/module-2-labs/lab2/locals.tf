locals {
  common_tags = {
    Environment = var.environment
    Project     = "iac-journey"
    ManagedBy   = "Terraform"
    Lab         = "module-2-lab-2"
  }
}