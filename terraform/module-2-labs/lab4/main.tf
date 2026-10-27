resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

module "audit_logs" {
  source = "./modules/bucket"
  name   = "myproject-audit-${random_string.suffix.result}"
}
