provider "aws" {
  region = "ap-southeast-1" # default: Singapore
}

provider "aws" {
  alias  = "tokyo"
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "backup" {
  provider = aws.tokyo # use the Tokyo copy
  bucket   = "my-backup-bucket"
}
