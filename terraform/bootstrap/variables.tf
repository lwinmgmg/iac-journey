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
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,30}$", var.project_name))
    error_message = "The project name must start with a lowercase letter and can only contain lowercase letters, numbers, and hyphens. It must be between 3 and 30 characters long."
  }
}

variable "aws_region" {
  type        = string
  default     = "ap-southeast-1"
  description = "The AWS region to deploy resources in"
}
