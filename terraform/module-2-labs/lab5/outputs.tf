output "account_id" {
  value       = data.aws_caller_identity.current.account_id
  description = "The AWS account ID of the current user."
}

output "region" {
  value       = data.aws_region.current.region
  description = "The AWS region in which resources are being created."
}

output "azs" {
  value       = local.azs
  description = "The list of availability zones being used."
}

output "subnet_cidrs" {
  value       = { for az, s in aws_subnet.public : az => s.cidr_block }
  description = "A map of availability zones to their corresponding subnet CIDR blocks."
}

output "al2023_ami_from_ssm" {
  value       = data.aws_ssm_parameter.al2023.insecure_value
  description = "The latest Amazon Linux 2023 AMI ID retrieved from SSM Parameter Store."
}

output "al2023_ami_from_search" {
  value       = "${data.aws_ami.al2023.id} (${data.aws_ami.al2023.creation_date})"
  description = "The latest Amazon Linux 2023 AMI ID retrieved from an AMI search."
}