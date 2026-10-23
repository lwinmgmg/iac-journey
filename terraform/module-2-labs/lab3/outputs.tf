output "counted_buckets" {
  value       = aws_s3_bucket.counted[*].bucket
  description = "The names of the counted S3 buckets"
}

output "keyed_buckets" {
  value       = { for k, b in aws_s3_bucket.keyed : k => b.bucket }
  description = "The names of the keyed S3 buckets"
}

output "security_group_id" {
  value       = aws_security_group.web.id
  description = "The ID of the created security group"
}