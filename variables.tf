variable "custom_domain" {
  type        = string
  description = "domain name you are using for the custom domain"
}

variable "intercom_help_domain" {
  type        = string
  description = "For Intercom US: custom.intercom.help; Intercom Europe: custom.eu.intercom.help; Intercom Australia: custom.au.intercom.help"
  default     = "custom.intercom.help"
}

variable "zone_id" {
  type        = string
  description = "zone_id for the dns records the module will create. It should be the zone that is backing var.custom_domain"
}

variable "origin_id" {
  type        = string
  description = "A unique identifier for the origin"
}

variable "tags" {
  type        = map(string)
  description = "tags for all resources in the module"
  default     = {}
}

variable "web_acl_id" {
  type        = string
  description = "aws_wafv2_web_acl arn or aws_waf_web_acl id. Default is null for no web acl"
  default     = null
}