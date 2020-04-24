terraform {
  required_version = ">= 0.12.1"
}

provider "aws" {
  version = "~> 2.50"

  assume_role {
    role_arn = var.aws_assume_role_arn
  }
}

module "label" {
  source    = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  namespace = var.namespace
  stage     = var.stage
  name      = var.name
}

resource "aws_iam_saml_provider" "provider" {
  name                   = module.label.id
  saml_metadata_document = file("${var.config_path}/metadata.xml")
}
