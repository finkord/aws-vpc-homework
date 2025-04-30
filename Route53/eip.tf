# Creating EIP
resource "aws_eip" "terraform_eip" {
  domain = "vpc"

  tags = {
    Name = "terraform_eip"
  }
}
