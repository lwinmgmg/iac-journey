variable "environment" {
  type        = string
  default     = "dev"
  description = "The environment for the resources (e.g., dev, stage, prod)"
  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "The environment must be one of 'dev', 'stage', or 'prod'."
  }
}

variable "project_name" {
  type        = string
  default     = "iac-journey"
  description = "The name of the project for tagging purposes"
}
