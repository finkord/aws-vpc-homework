// Create route table association public subnet
resource "aws_route_table_association" "terraform_public_assoc" {
  subnet_id      = aws_subnet.terraform_public_subnet.id
  route_table_id = aws_route_table.terraform_public_RT.id
}
// Create route table association private subnet
resource "aws_route_table_association" "terraform_private_assoc" {
  subnet_id      = aws_subnet.terraform_private_subnet.id
  route_table_id = aws_route_table.terraform_private_RT.id
}
