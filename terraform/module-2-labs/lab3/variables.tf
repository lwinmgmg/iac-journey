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

variable "names" {
  description = "A list of names for the S3 buckets"
  type        = list(string)
  default     = ["alpha", "bravo", "charlie"]
}

variable "ingress_rules" {
  description = "A list of ingress rules for the security group"
  type        = list(object({ description = string, port = number, cidr = string }))
  default = [
    { description = "Allow HTTP", port = 80, cidr = "0.0.0.0/0" },
    { description = "Allow HTTPS", port = 443, cidr = "0.0.0.0/0" }
  ]
}