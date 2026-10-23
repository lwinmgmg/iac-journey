variable "environment" {
  description = "The environment for the resources (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "The environment must be one of: dev, stage, prod."
  }
}

variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "ap-southeast-1"
}

variable "project" {
  description = "The project name for the resources"
  type        = string
  default     = "myproject"
  validation {
    condition     = can(regex("^[a-z0-9_]+$", var.project))
    error_message = "The project name must only contain lowercase letters, numbers, and underscores."
  }
}
