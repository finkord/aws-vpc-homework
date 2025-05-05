/* 
*   Create Routetable for Public Subnet
*/
resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.vpc.id

  route {
    gateway_id = aws_internet_gateway.internet_gateway.id
    cidr_block = "0.0.0.0/0"
  }

  depends_on = [aws_internet_gateway.internet_gateway]

  tags = {
    Name        = "Public Routetable"
    Description = "Created with Terraform"
  }
}

/* 
*   Create Routetable for Private Subnet
*/
resource "aws_route_table" "private_rt" {

  vpc_id = aws_vpc.vpc.id

  route {
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
    cidr_block     = "0.0.0.0/0"
  }

  depends_on = [aws_nat_gateway.nat_gateway]

  tags = {
    Name        = "Private Routetable"
    Description = "Created with Terraform"
  }
}
