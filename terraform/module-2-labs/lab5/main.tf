locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "myproject-lab5"

  }
  lifecycle {
    ignore_changes = [tags["Owner"]]
  }
}

resource "aws_subnet" "public" {
  for_each = {
    for i, az in local.azs : az => cidrsubnet(var.vpc_cidr, 8, i)
  }
  vpc_id            = aws_vpc.this.id
  availability_zone = each.key
  cidr_block        = each.value

  lifecycle {
    precondition { # checked BEFORE this resource is planned
      condition     = length(local.azs) >= 2
      error_message = "Need at least two AZs."
    }
  }
}

resource "aws_s3_bucket" "data" {
  bucket = "myproject-lab5-data-${data.aws_caller_identity.current.account_id}"
  tags = {
    Name = "myproject-lab5-data"
  }
  lifecycle { prevent_destroy = false }
}

resource "aws_s3_bucket_versioning" "data" {
  bucket = aws_s3_bucket.data.id
  versioning_configuration {
    status = var.versioning_status
  }

  lifecycle {
    postcondition { # checks the RESULT; self = this resource
      condition     = var.versioning_status == "Enabled"
      error_message = "Versioning must be enabled."
    }
  }
}