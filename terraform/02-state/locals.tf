locals {
  project_name   = var.project
  lab_name       = "02-state"
  environment    = var.environment
  default_region = "ap-southeast-1"
  default_tags = {
    Project     = local.project_name
    Lab         = local.lab_name
    Environment = local.environment
  }
}