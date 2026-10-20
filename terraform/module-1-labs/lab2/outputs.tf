output "public_key" {
  value = tls_private_key.lab.public_key_openssh
}

output "private_key" {
  value     = tls_private_key.lab.private_key_openssh
  sensitive = true
}


output "private_key_path" {
  description = "Where the private key was written"
  value       = local_sensitive_file.private_key.filename
}
