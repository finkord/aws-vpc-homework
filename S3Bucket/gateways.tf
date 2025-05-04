/* 
*  Create Internet Gateway
*/
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  depends_on = [aws_vpc.vpc]

  tags = {
    Name        = "Internet Gateway"
    Description = "Created with Terraform"
  }
}

/* 
*  Create NAT Gateway
*/
resource "aws_nat_gateway" "nat_gateway" {
  subnet_id     = aws_subnet.public_subnet.id
  allocation_id = aws_eip.eip.id

  depends_on = [aws_subnet.public_subnet, aws_eip.eip]

  tags = {
    Name        = "NAT Gateway"
    Description = "Created with Terraform"
  }
}
