resource "aws_route53_zone" "default" {
  name = var.domain
}

resource "aws_route53_record" "default" {
  zone_id = aws_route53_zone.default.id
  name = ""
  type = "A"
  ttl = 300
  # 後でLBに変更する
  records = [aws_eip.bastion.public_ip]
}