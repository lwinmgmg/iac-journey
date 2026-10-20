output "name" {
  description = "Name of the Pet resource"
  value       = random_pet.name.id
}

output "tags" {
  description = "Tags of the local resource"
  value       = local.tags
}