resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "counted" {
  count  = length(var.names)                                                               # ["alpha", "bravo", "charlie"]
  bucket = "${var.project}-count-${var.names[count.index]}-${random_string.suffix.result}" # counted[0], [1], [2]
}

resource "aws_s3_bucket" "keyed" {
  for_each = toset(var.names)                                                 # {"alpha", "bravo", "charlie"}
  bucket   = "${var.project}-each-${each.key}-${random_string.suffix.result}" # keyed["alpha"], ["bravo"], ["charlie"]
}

data "aws_vpc" "default" { default = true }

resource "aws_security_group" "web" {
  vpc_id = data.aws_vpc.default.id
  name   = "${var.project}-web-${var.environment}"
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
