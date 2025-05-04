/* 
*   Create VPC 
*/
resource "aws_vpc" "vpc" {

  cidr_block           = "10.0.0.0/21"
  enable_dns_hostnames = true

  tags = {
    Name        = "VPC"
    Description = "Created with Terraform"
  }
}

/* 
*  Create Public and Private Subnets in VPC 
*/
resource "aws_subnet" "public_subnet" {

  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/23"

  depends_on = [aws_vpc.vpc]

  tags = {
    Name        = "Public Subnet"
    Description = "Created with Terraform"
  }
}

resource "aws_subnet" "private_subnet" {

  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/23"

  depends_on = [aws_vpc.vpc]

  tags = {
    Name        = "Private Subnet"
    Description = "Created with Terraform"
  }
}

/* 
*  Create Endpoin for S3 Bucket
*/
resource "aws_vpc_endpoint" "endpoint" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.public_rt.id, aws_route_table.private_rt.id
  ]
}
