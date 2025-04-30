// Create routetable for public subnet
resource "aws_route_table" "terraform_public_RT" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_gw.id
  }

  tags = {
    Name = "terraform_public_RT"
  }

  depends_on = [aws_internet_gateway.terraform_gw, aws_vpc.terraform_vpc]
}
// Create routetable for private subnet
resource "aws_route_table" "terraform_private_RT" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.terraform_nat_gw.id
  }

  tags = {
    Name = "terraform_private_RT"
  }

  depends_on = [aws_nat_gateway.terraform_nat_gw, aws_vpc.terraform_vpc]
}
