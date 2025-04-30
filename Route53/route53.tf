resource "aws_route53_zone" "terraform_route53" {
  name = "finkord.pp.ua"
}

resource "aws_route53_record" "terraform_cname_record" {
  zone_id = aws_route53_zone.terraform_route53.zone_id
  name    = "app.finkord.pp.ua"

  type    = "CNAME"
  ttl     = 200
  records = [aws_lb.terraform_nlb.dns_name]
}
