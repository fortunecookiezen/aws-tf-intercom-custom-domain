# aws-tf-intercom-custom-domain

Creates AWS resources to enable Intercom Custom Domains for Articles

Based upon these instructions: [Custom Domains for Articles](https://developers.intercom.com/installing-intercom/docs/set-up-your-custom-domain)

You can register for an Intercom developer account at [app.intercom.com/a/signup/teams](https://app.intercom.com/a/signup/teams?developer=true)

### *Note: this module can only be called in us-east-1 region*

<!-- BEGIN_TF_DOCS -->


## Usage

```hcl
module "intercom" {
    source = "../"
    custom_domain = "support.fortunecookiezen.net"
    zone_id = "JADZZZJADOAMDALD8H"
    origin_id = "fortunecookiezen-origin"
    tags = {
        owner = "support@fortunecookiezen.net"
    }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain) | domain name you are using for the custom domain | `string` | n/a | yes |
| <a name="input_intercom_help_domain"></a> [intercom\_help\_domain](#input\_intercom\_help\_domain) | For Intercom US: custom.intercom.help; Intercom Europe: custom.eu.intercom.help; Intercom Australia: custom.au.intercom.help | `string` | `"custom.intercom.help"` | no |
| <a name="input_origin_id"></a> [origin\_id](#input\_origin\_id) | A unique identifier for the origin | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | tags for all resources in the module | `map(string)` | `{}` | no |
| <a name="input_web_acl_id"></a> [web\_acl\_id](#input\_web\_acl\_id) | aws\_wafv2\_web\_acl arn or aws\_waf\_web\_acl id. Default is null for no web acl | `string` | `null` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | zone\_id for the dns records the module will create. It should be the zone that is backing var.custom\_domain | `string` | n/a | yes |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_route53_record.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_domain_name"></a> [cloudfront\_domain\_name](#output\_cloudfront\_domain\_name) | The domain name corresponding to the distribution. |
| <a name="output_cloudfront_hosted_zone_id"></a> [cloudfront\_hosted\_zone\_id](#output\_cloudfront\_hosted\_zone\_id) | The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID `Z2FDTNDATAQYW2`. |
<!-- END_TF_DOCS -->