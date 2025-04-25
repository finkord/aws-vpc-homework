# Creating EIP
resource "aws_eip" "terraform_eip" {
  domain = "vpc"

  tags = {
    Name = "terraform_eip"
  }

  depends_on = [aws_vpc.terraform_vpc]
}
