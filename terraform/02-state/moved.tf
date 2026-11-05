moved {
  from = aws_s3_bucket.logs
  to   = aws_s3_bucket.this["logs"]
}

moved {
  from = aws_s3_bucket_versioning.logs
  to   = aws_s3_bucket_versioning.this["logs"]
}

moved {
  from = aws_s3_bucket_public_access_block.logs
  to   = aws_s3_bucket_public_access_block.this["logs"]
}