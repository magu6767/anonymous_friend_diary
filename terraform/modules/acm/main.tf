# modules/acm/main.tf

# ACM証明書のリソース定義
resource "aws_acm_certificate" "dpp_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name = "DPP_SSL_Certificate"
  }
}

# 証明書のDNS検証用レコードの作成
resource "aws_route53_record" "dpp_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.dpp_cert.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = var.route53_zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.value]
}

# 証明書の検証を完了させる
resource "aws_acm_certificate_validation" "dpp_cert_validation" {
  certificate_arn         = aws_acm_certificate.dpp_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.dpp_cert_validation : record.fqdn]
}