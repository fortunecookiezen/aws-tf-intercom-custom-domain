output "cloudfront_domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_hosted_zone_id" {
  description = "The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID `Z2FDTNDATAQYW2`."
  value       = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
}