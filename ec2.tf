resource "aws_instance" "terraform_public_ec2" {
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.terraform_public_subnet.id
  associate_public_ip_address = true
  key_name                    = "terraform_public_key"
  vpc_security_group_ids      = [aws_security_group.terraform_public_SG.id]

  tags = {
    Name = "terraform_public_ec2"
  }

  depends_on = [aws_vpc.terraform_vpc]
}

resource "aws_instance" "terraform_private_ec2" {
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.terraform_private_subnet.id
  associate_public_ip_address = false
  key_name                    = "terraform_public_key"
  vpc_security_group_ids      = [aws_security_group.terraform_private_SG.id]

  tags = {
    Name = "terraform_private_ec2"
  }

  depends_on = [aws_vpc.terraform_vpc]
}

