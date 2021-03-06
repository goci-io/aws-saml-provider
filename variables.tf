
variable "namespace" {
  type        = string
  description = "Organization or company prefix"
}

variable "stage" {
  type        = string
  default     = ""
  description = "Stage the resources will be created for"
}

variable "name" {
  type        = string
  default     = ""
  description = "Name for the module as suffix for all resources"
}

variable "saml_provider_name" {
  type        = string
  description = "Name of the SAML provider to use (eg: okta, auth0, ..)"
}

variable "config_path" {
  type        = string
  default     = "."
  description = "Path to a directory containing metadata.xml for the SAML provider configuration"
}

variable "fail_on_missing_config" {
  type        = bool
  default     = true
  description = "Fails when metadata.xml cannot be found. Creates no resources otherwise"
}

variable "saml_provider_metadata" {
  type        = string
  default     = ""
  description = "Plain SAML provider metadata manifest"
}

variable "permissions" {
  type = list(object({
    actions    = list(string)
    resources  = list(string)
    principals = map(string)
  }))
  default     = []
  description = "Additional policy documents to attach to the SAML admin role"
}

variable "create_alias_record" {
  type        = bool
  default     = false
  description = "Creates an Alias record on Route53 and a Redirect bucket to create an alias for the SAML login url"
}

variable "saml_login_url" {
  type        = string
  default     = ""
  description = "Full URL to the SAML login page"
}

variable "alias_record_fqdn" {
  type        = string
  default     = ""
  description = "Full domain name to use for the alias record (eg: aws.my-company.com)"
}

variable "hosted_zone_name" {
  type        = string
  default     = ""
  description = "The Name of the hosted zone to create the alias record in"
}
