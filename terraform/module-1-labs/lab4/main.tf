variable "names" {
  type        = list(string)
  default     = ["web", "api", "db", "test"]
  description = "List of names for the resources"
}

variable "instance_types" {
  type        = map(string)
  default     = { dev = "t3.micro", prod = "t3.small" }
  description = "Map of instance types for different environments"
}

locals {
  upper_names   = [for name in var.names : upper(name)]
  name_lengths  = {for name in var.names : name => length(name)}
  without_test  = [for name in var.names : name if name != "test"]
  subnets       = [for i in range(3) : cidrsubnet("10.0.0.0/16", 8, i)]
  stage_type    = lookup(var.instance_types, "stage", "t3.micro")
  bucket_policy = jsonencode({ Version = "2012-10-17", Statement = [] })
}

output "upper_names" {
  value = local.upper_names
}

output "name_lengths" {
  value = local.name_lengths
}   

output "without_test" {
  value = local.without_test
}

output "subnets" {
  value = local.subnets
}

output "stage_type" {
  value = local.stage_type
}

output "bucket_policy" {
  value = local.bucket_policy
}
