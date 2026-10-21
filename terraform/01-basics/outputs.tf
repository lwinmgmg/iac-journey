output "bucket_name" {
  value       = aws_s3_bucket.lab.bucket
  description = "The name of the S3 bucket created for lab 5"
}

output "bucket_arn" {
  value       = aws_s3_bucket.lab.arn
  description = "The ARN of the S3 bucket created for lab 5"
}
