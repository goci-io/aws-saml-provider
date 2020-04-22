
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
  default     = "saml"
  description = "Name for the module as suffix"
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

variable "permissions" {
  type        = list(object({
    actions    = list(string)
    resources  = list(string)
    principals = map(string)
  }))
  default     = []
  description = "Additional policy documents to attach to the SAML admin role"
}
