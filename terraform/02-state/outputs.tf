output "bucket_names" {
  value       = { for k, b in aws_s3_bucket.this : k => b.bucket }
  description = "The names of the created S3 buckets"
}

output "bucket_arns" {
  value       = { for k, b in aws_s3_bucket.this : k => b.arn }
  description = "The ARNs of the created S3 buckets"
}
