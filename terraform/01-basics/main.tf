resource "random_string" "suffix" {
  length  = 6     # 6 random characters
  upper   = false # no capital letters
  special = false # no symbols like ! @ # $
}

resource "aws_s3_bucket" "lab" {
  bucket = local.bucket_name
  tags   = { Lab = "01-basics" }
}

resource "aws_s3_bucket_versioning" "lab" {
  bucket = aws_s3_bucket.lab.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "lab" {
  bucket = aws_s3_bucket.lab.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}