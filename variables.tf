
variable "namespace" {
  type        = string
  description = "Organization or company prefix"
}

variable "stage" {
  type        = string
  default     = ""
  description = "Stage the resources will be created for"
}

variable "saml_provider_name" {
  type        = string
  description = "Name of the SAML provider to use (eg: okta, auth0, ..)"
}
