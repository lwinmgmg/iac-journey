resource "random_pet" "name" {
  length = var.pet_length
  prefix = local.prefix_name
}

resource "local_file" "tags" {
  filename        = "${path.module}/tags.json"
  content         = jsonencode(local.tags)
  file_permission = "0644"
}


