resource "random_password" "old_way" {
  length = 20
}

resource "aws_ssm_parameter" "old_way" {
  name  = "/myproject/lab6/old_way_password"
  type  = "SecureString"
  value = random_password.old_way.result
}

ephemeral "random_password" "db" {
  length = 20
}

resource "aws_ssm_parameter" "db_password" {
  name             = "/myproject/lab6/db_password"
  type             = "SecureString"
  value_wo         = ephemeral.random_password.db.result
  value_wo_version = var.db_password_version
}

resource "aws_ssm_parameter" "api_token" {
  name             = "/myproject/lab6/api-token"
  type             = "SecureString"
  value_wo         = var.api_token
  value_wo_version = 1
}


