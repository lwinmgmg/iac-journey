resource "random_pet" "name" {
  length = 2
}

resource "aws_s3_bucket" "drift" {
  bucket = "${var.project}-drift-${random_pet.name.id}"

}

resource "aws_s3_bucket_versioning" "drift" {
  bucket = aws_s3_bucket.drift.id
  versioning_configuration {
    status = "Enabled"
  }
}

