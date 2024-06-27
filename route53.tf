resource "aws_route53_zone" "hosted-zone" {
  name = "abdalaresume.online"
}

resource "aws_route53_record" "CNAME-record" {
  zone_id = aws_route53_zone.hosted-zone.zone_id
  name    = "_43c725e269a85634a0498e4cfdeffba9"
  type    = "CNAME"
  ttl     = "60"
  records = ["_8645efd1e185f9244dd1f316ae8a049e.sdgjtdhdhz.acm-validations.aws."]
}