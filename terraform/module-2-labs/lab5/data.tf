data "aws_caller_identity" "current" {}     # .account_id (used in your state bucket)
data "aws_region" "current" {}              # .region
data "aws_availability_zones" "available" { # .names = ["ap-southeast-1a", ...]
  state = "available"
}

# Latest Amazon Linux 2023 AMI, the easy way: AWS publishes it in SSM
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# or search with filters
data "aws_ami" "al2023" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}