variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "The provided VPC CIDR block is invalid."
  }
}

variable "versioning_status" {
  type    = string
  default = "Enabled"
  validation {
    condition     = contains(["Enabled", "Suspended"], var.versioning_status)
    error_message = "Versioning status must be either 'Enabled' or 'Suspended'."
  }
}