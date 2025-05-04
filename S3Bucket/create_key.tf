/* 
*   Create RSA 4096 key
*/
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

/* 
*   Create key_pair
*/
resource "aws_key_pair" "key_pair" {
  key_name   = "public_key"
  public_key = tls_private_key.key.public_key_openssh
}

/* 
*   Save key to local machine
*/
resource "local_sensitive_file" "private_key_file" {
  content  = tls_private_key.key.private_key_openssh
  filename = "${path.module}/sshkey-${aws_key_pair.key_pair.key_name}.pem"
}
