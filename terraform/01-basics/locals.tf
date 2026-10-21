locals {
  project_name = var.project_name
  managed_by   = "terraform"
  Environment  = var.environment
  common_tags = {
    Project     = local.project_name
    Environment = local.Environment
    ManagedBy   = local.managed_by
  }

  bucket_name = "${local.project_name}-${local.Environment}-${random_string.suffix.result}"
}