locals {
  prefix_name = "${var.project}-${var.environment}" # e.g. "iac-journey-dev"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }
  tags = merge(local.common_tags, var.extra_tags)
}