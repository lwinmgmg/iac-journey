resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "aws_s3_bucket" "this" {
  for_each = var.buckets
  bucket   = coalesce(each.value.name, "${var.project}-${var.environment}-${each.key}-${random_string.suffix.result}")

  tags = {
    Purpose = each.value.purpose
  }
}

resource "aws_s3_bucket_versioning" "this" {
  for_each = { for k, v in var.buckets : k => v if v.versioning }
  bucket   = aws_s3_bucket.this[each.key].id

  versioning_configuration {
    status = "Enabled"
  }

  lifecycle {
    postcondition {
      condition     = self.versioning_configuration[0].status == "Enabled"
      error_message = "Versioning must be enabled for bucket ${each.key}."
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  for_each = var.buckets
  bucket   = aws_s3_bucket.this[each.key].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
