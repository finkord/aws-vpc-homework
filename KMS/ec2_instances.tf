/* 
*   Create Bastion Instance in Public Subnet
*/
resource "aws_instance" "bastion" {

  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  // For SSH
  key_name = "public_key"

  user_data = filebase64("${path.module}/install_aws_cli.sh")

  iam_instance_profile = aws_iam_instance_profile.profile.name

  depends_on = [aws_vpc.vpc]

  tags = {
    Name        = "Bastion Instance"
    Description = "Created with Terraform"
  }
}

