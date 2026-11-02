output "bucket_names" {
  value       = { for bucket in aws_s3_bucket.this : bucket.bucket => bucket.id }
  description = "The names of the created S3 buckets"
}

output "bucket_arns" {
  value       = { for bucket in aws_s3_bucket.this : bucket.bucket => bucket.arn }
  description = "The ARNs of the created S3 buckets"
}
