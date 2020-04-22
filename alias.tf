module "records" {
  source        = "git::https://github.com/goci-io/aws-route53-records.git?ref=tags/0.3.0"
  enabled       = var.create_alias_record
  hosted_zone   = var.hosted_zone_name
  alias_records = [
    {
      name       = replace(var.alias_record_fqdn, var.hosted_zone_name, "")
      alias      = join("", aws_s3_bucket.redirect.*.website_domain)
      alias_zone = join("", aws_s3_bucket.redirect.*.hosted_zone_id)
    }
  ]
}

resource "aws_s3_bucket" "redirect" {
  count  = var.create_alias_record ? 1 : 0
  bucket = var.alias_record_fqdn
  acl    = "private"

  website {
    redirect_all_requests_to = var.saml_login_url
  }
}
