removed {
  from = aws_s3_bucket.handmade
  lifecycle {
    destroy = false
  }
}
