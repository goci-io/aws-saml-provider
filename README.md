# aws-saml-provider

**Maintained by [@goci-io/prp-terraform](https://github.com/orgs/goci-io/teams/prp-terraform)**

![terraform](https://github.com/goci-io/aws-saml-provider/workflows/terraform/badge.svg?branch=master)

This module creates an AWS SAML Provider by using the provided `metadata.xml`. You can also change the path to the provider config.
Additionally an IAM role is created which grants `PowerUser` permissions and permissions defined in `permissions`.
When desired you can also create an alias record pointing to your SAML login URL for convenience.

### Usage

```hcl

module "saml_provider" {
  source              = "git::https://github.com/goci-io/aws-saml-provider.git?ref=tags/<latest_version>"
  namespace           = "my-company"
  stage               = "staging"
  saml_provider_name  = "<provider-name>"
}
```

You can also configure an alias record on Route53 to point to your Login SAML URL for convenience as these URLs usually contain long ids or hashes. Add the following arguments to your module configuration:

```hcl
module "saml_provider" {
  ... # Auth0 example
  saml_provider_name  = "auth0"
  create_alias_record = true
  hosted_zone_name    = "my-company.io"
  alias_record_fqdn   = "aws.my-company.io"
  saml_login_url      = "https://my-company.auth0.com/samlp/<saml_login_url>"
}
```

Now you can use `aws.my-company.io` to get to the SSO page.
