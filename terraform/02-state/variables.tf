variable "project" {
  description = "The project name for the resources"
  type        = string
  default     = "iac-journey"
  validation {
    condition     = can(regex("^[a-z]+[a-z0-9-]*$", var.project))
    error_message = "The project name must be a valid string. It should start with a lowercase letter and can contain lowercase letters and numbers."
  }
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "The environment must be one of: dev, staging, prod."
  }
}

variable "buckets" {
  description = "A list of S3 bucket names to create"
  type        = map(object({ purpose = string, versioning = optional(bool, true), name = optional(string) }))
  default = {
    "logs" = {
      purpose    = "Store application logs"
      versioning = true
    },
    "artifacts" = {
      purpose    = "Store build artifacts"
      versioning = true
    },
    "legacy" = {
      purpose    = "Store legacy data"
      versioning = false
      name       = "myproject-handmade-htet"
    }
  }
}