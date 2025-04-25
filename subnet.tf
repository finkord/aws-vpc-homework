// Create public subnet in VPC
resource "aws_subnet" "terraform_public_subnet" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.1.0.0/23"

  tags = {
    Name = "terraform_public_subnet"
  }

  depends_on = [aws_vpc.terraform_vpc]
}
// Create private subnet in VPC
resource "aws_subnet" "terraform_private_subnet" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.1.2.0/23"

  tags = {
    Name = "terraform_private_subnet"
  }

  depends_on = [aws_vpc.terraform_vpc]
}

