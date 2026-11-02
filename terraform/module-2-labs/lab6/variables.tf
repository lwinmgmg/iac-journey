variable "api_token" {
  type      = string
  sensitive = true
  ephemeral = true
}

variable "db_password_version" {
  type    = number
  default = 1
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}