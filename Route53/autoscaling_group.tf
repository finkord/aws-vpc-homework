resource "aws_launch_template" "terraform_launch_template" {
  name_prefix   = "terraform_launch_template"
  description   = "Launch template for my nginx servers"
  image_id      = "ami-084568db4383264d4"
  instance_type = "t2.micro"

  key_name = aws_key_pair.terraform_key_pair.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.terraform_asg_SG.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      name = "terraform_launch_template"
    }
  }

  user_data = filebase64("${path.module}/nginx.sh")
}


resource "aws_autoscaling_group" "terraform_autoscaling_group" {
  name                = "terraform_autoscaling_group"
  max_size            = 3
  min_size            = 1
  desired_capacity    = 1
  vpc_zone_identifier = [aws_subnet.terraform_private_subnet.id]
  target_group_arns   = [aws_lb_target_group.terraform_nlb_target.arn]

  launch_template {
    id      = aws_launch_template.terraform_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 30
  force_delete              = true
  wait_for_capacity_timeout = "0"
}
