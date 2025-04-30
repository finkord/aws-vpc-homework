resource "aws_lb" "terraform_nlb" {
  name               = "nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.terraform_public_subnet.id]
  security_groups    = [aws_security_group.terraform_elb_SG.id]

  enable_deletion_protection = false
}
resource "aws_lb_target_group" "terraform_nlb_target" {
  name     = "nlb-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.terraform_vpc.id

  target_type = "instance"
  health_check {
    protocol = "TCP"
    port     = 80
    interval = 30
  }
}
resource "aws_lb_listener" "terraform_nlb_listener" {
  load_balancer_arn = aws_lb.terraform_nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terraform_nlb_target.arn
  }
}
