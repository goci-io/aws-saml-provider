terraform {
  required_version = ">= 0.12.1"
}

provider "aws" {
  version = "~> 2.50"

  assume_role {
    role_arn = var.aws_assume_role_arn
  }
}

locals {
  metadata_path   = "${var.config_path}/metadata.xml"
  exists_metadata = !var.fail_on_missing_config && fileexists(local.metadata_path)
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
  saml_metadata_document = file(local.metadata_path)
}
