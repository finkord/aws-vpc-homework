// Create RAS 4096 key
resource "tls_private_key" "terraform_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
// Create key_pair
resource "aws_key_pair" "terraform_key_pair" {
  key_name   = "terraform_public_key"
  public_key = tls_private_key.terraform_key.public_key_openssh
}
// Save key to local machine
resource "local_sensitive_file" "private_key_file" {
  content  = tls_private_key.terraform_key.private_key_openssh
  filename = "${path.module}/sshkey-${aws_key_pair.terraform_key_pair.key_name}.pem"
}
