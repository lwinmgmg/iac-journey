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
  for_each = var.buckets
  bucket   = aws_s3_bucket.this[each.key].id

  versioning_configuration {
    status = each.value.versioning ? "Enabled" : "Suspended"
  }

  lifecycle {
    postcondition {
      condition     = self.versioning_configuration[0].status == "Enabled"
      error_message = "Versioning must be enabled for bucket ${each.key}."
    }
  }
}

# resource "aws_s3_bucket" "logs" {
#   bucket   = "${var.project}-${var.environment}-logs-${random_string.suffix.result}"
#   tags = {
#     Purpose = var.buckets["logs"].purpose
#   }
# }

# resource "aws_s3_bucket_versioning" "logs" {
#   bucket = aws_s3_bucket.logs.id

#   versioning_configuration {
#     status = var.buckets["logs"].versioning ? "Enabled" : "Suspended"
#   }
# }
