terraform {
  required_version = ">= 0.12.1"
}

provider "aws" {
  version = "~> 2.50"
}

module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.saml_provider_name
}

resource "aws_iam_saml_provider" "provider" {
  name                   = module.saml_label.id
  saml_metadata_document = "${file("metadata.xml")}"
}
