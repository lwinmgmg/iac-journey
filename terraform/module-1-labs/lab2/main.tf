resource "tls_private_key" "lab" {
  algorithm = "ED25519"
}

resource "local_sensitive_file" "private_key" {
  filename        = "${path.module}/keys/lab_ed25519"
  content         = tls_private_key.lab.private_key_openssh
  file_permission = "0600"
}

resource "local_file" "public_key" {
  filename        = "${path.module}/keys/lab_ed25519.pub"
  content         = tls_private_key.lab.public_key_openssh
  file_permission = "0644"
}
