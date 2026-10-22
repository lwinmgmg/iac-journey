terraform {
  backend "s3" {
    key = "01-basics/terraform.tfstate" # path of the object in the bucket
  }
}