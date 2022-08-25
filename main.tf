provider "aws" {
  version = "~> 4.0"
  region  = "us-east-1"
}
resource "aws_route53_record" "domain" {
  zone_id = var.zone_id
  name    = var.custom_domain
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate_validation" "cert" {
  for_each = {
  }
  certificate_arn         = aws_acm_certificate.domain.arn
  validation_record_fqdns = [aws_route53_record.validation[each.key].fqdn]
}

resource "aws_acm_certificate" "domain" {
  domain_name       = var.custom_domain
  validation_method = "DNS"

  tags = merge(var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.domain.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  zone_id         = var.zone_id
  ttl             = 60
  type            = each.value.type
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.intercom_help_domain
    origin_id   = var.origin_id

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  aliases         = [var.custom_domain]
  price_class     = "PriceClass_All"
  enabled         = true
  is_ipv6_enabled = true
  comment         = "Intercom Custom Domain"
  http_version    = "http2"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.origin_id

    forwarded_values {
      headers      = ["*"]
      query_string = true

      cookies {
        forward = "all"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  tags       = merge(var.tags)
  web_acl_id = var.web_acl_id
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.domain.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }
}
