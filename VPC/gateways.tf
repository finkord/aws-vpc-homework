// Create gateway
resource "aws_internet_gateway" "terraform_gw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "terraform_gw"
  }

  depends_on = [aws_vpc.terraform_vpc]
}
// Creating NAT Gateway
resource "aws_nat_gateway" "terraform_nat_gw" {
  allocation_id = aws_eip.terraform_eip.id
  subnet_id     = aws_subnet.terraform_public_subnet.id

  depends_on = [aws_internet_gateway.terraform_gw, aws_eip.terraform_eip, aws_subnet.terraform_public_subnet]
}
