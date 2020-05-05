terraform {
  required_version = ">= 0.12.1"

  required_providers {
    aws = "~> 2.50"
  }
}

locals {
  metadata_path   = "${var.config_path}/metadata.xml"
  exists_metadata = var.saml_provider_metadata != "" || (! var.fail_on_missing_config && fileexists(local.metadata_path))
}

module "label" {
  source    = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  namespace = var.namespace
  stage     = var.stage
  name      = var.name
}

resource "aws_iam_saml_provider" "provider" {
  count                  = local.exists_metadata ? 1 : 0
  name                   = module.label.id
  saml_metadata_document = var.saml_provider_metadata != "" ? var.saml_provider_metadata : file(local.metadata_path)
}
