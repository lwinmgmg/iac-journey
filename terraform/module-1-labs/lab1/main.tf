terraform {
  required_version = "~> 1.16"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

resource "random_pet" "name" {
  length = 3
}

resource "local_file" "greeting" {
  content  = "Hello, ${random_pet.name.id}!\n"
  filename = "${path.module}/hello.txt"
}

output "pet_name" {
  value = random_pet.name.id
}