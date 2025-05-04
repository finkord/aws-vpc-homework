/* 
*   Create EIP
*/
resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name        = "EIP"
    Description = "Created with Terraform"
  }
}
