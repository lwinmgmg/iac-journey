variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "environment must be dev, stage or prod."
  }
}

variable "project" {
  description = "Deployment project"
  type        = string
  default     = "Lab2"
}

locals {
  name_prefix = "${var.project}-${var.environment}" # e.g. "iac-journey-dev"

  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
