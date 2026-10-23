output "bucket_name" {
  value       = aws_s3_bucket.drift.bucket
  description = "The name of the S3 bucket"
}