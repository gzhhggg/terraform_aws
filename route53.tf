resource "aws_route53_zone" "default" {
  name = var.domain
}

resource "aws_route53_record" "default" {
  zone_id = aws_route53_zone.default.id
  name    = ""
  type    = "A"
  alias {
    name                   = aws_lb.default.dns_name
    zone_id                = aws_lb.default.zone_id
    evaluate_target_health = true
  }
}