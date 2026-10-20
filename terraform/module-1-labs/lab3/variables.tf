variable "project" {
  type        = string
  description = "Project Name"
  default     = "lab3"
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,20}$", var.project))
    error_message = "Project name must be 3-20 characters long and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "environment" {
  type        = string
  description = "Deployment Environment"
  default     = "dev"

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "environment must be dev, stage or prod."
  }
}

variable "extra_tags" {
  type        = map(string)
  description = "Extra tags to add to resources"
  default     = {}
}

variable "pet_length" {
  type        = number
  description = "Length of the pet name to generate"
  default     = 2

  validation {
    condition     = var.pet_length >= 2 && var.pet_length <= 10
    error_message = "pet_length must be between 2 and 10."
  }
}
