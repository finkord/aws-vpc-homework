// Create VPC
resource "aws_vpc" "terraform_vpc" {
  cidr_block           = "10.0.0.0/21"
  enable_dns_hostnames = true

  tags = {
    Name = "terraform_vpc"
  }
}






