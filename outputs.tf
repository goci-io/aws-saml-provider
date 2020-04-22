output "saml_provider_arn" {
  value = aws_iam_saml_provider.provider.arn
}

output "saml_admin_role_arn" {
  value = aws_iam_role.saml_admin.arn
}
