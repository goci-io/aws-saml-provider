module "iam_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  context    = module.label.context
  attributes = ["admin"]
}

data "aws_iam_policy_document" "saml_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_saml_provider.provider.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "SAML:aud"
      values   = ["https://signin.aws.amazon.com/saml"]
    }
  }
}

data "aws_iam_policy_document" "permissions" {
  dynamic "statement" {
    for_each = var.permissions

    content {
      effect    = "Allow"
      actions   = statement.value.actions
      resources = statement.value.resources

      dynamic "principals" {
        for_each = statement.value.resources

        content {
          type        = principals.key
          identifiers = principals.value 
        }
      } 
    }
  }
}

resource "aws_iam_policy" "permissions" {
  count       = length(var.permissions) > 0 ? 1 : 0
  name        = module.iam_label.id
  path        = "/saml"
  policy      = data.aws_iam_policy_document.permissions.json
  description = "Grants additional permissions for SAML admin role"
}

resource "aws_iam_role" "saml_admin" {
  name                  = module.iam_label.id
  tags                  = module.iam_label.tags
  max_session_duration  = 3600
  force_detach_policies = true
  path                  = "/saml/${var.saml_provider_name}"
  description           = "Role to grant PowerUser access to users from SAML Provider ${module.label.id}"
  assume_role_policy    = data.aws_iam_policy_document.saml_trust.json
}

resource "aws_iam_role_policy_attachment" "power_access" {
  role       = aws_iam_role.saml_admin.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_role_policy_attachment" "permissions" {
  count      = length(var.permissions) > 0 ? 1 : 0
  role       = aws_iam_role.saml_admin.name
  policy_arn = element(aws_iam_policy.permissions.*.arn, count.index)
}
