# cloudflare-zone
A Terraform module to create a domain zone in Cloudflare and add DNS the simpleway.
It creates:
* Zone;
* Zone settings;
* Naked A record, if provided;
* Naked AAAA record, if provided;
* WWW CNAME to naked;
* all additional records provided.

## Usage on terraform >= v1.0
```hcl
provider "cloudflare" {
  email   = ""
  api_key = ""
  version = ">= 3.32"
}

module "domain_com" {
  source  = "tcarrondo/zone/cloudflare"
  version = "4.1.0"

  domain = "domain.com"

  ipv4 = ["1.2.3.4"]
  ipv6 = ["2607:f0d0:1002:51::4"]

  records = {
    mail = {
      name    = "mail"
      value   = "1.2.3.4"
    },
    mx_10 = {
      name     = "${module.domain_com.domain}"
      value    = "mail.${module.domain_com.domain}"
      type     = "MX"
      priority = "10"
      proxied  = false
    },
  }
}
```

## Usage on terraform <=v0.13
```hcl
provider "cloudflare" {
  email   = ""
  api_key = ""
  version = "~> 2.2"
}

module "domain_com" {
  source  = "tcarrondo/zone/cloudflare"
  version = "3.0.0"

  domain = "domain.com"

  ipv4 = ["1.2.3.4"]
  ipv6 = ["2607:f0d0:1002:51::4"]

  records = [
    {
      name    = "mail"
      value   = "1.2.3.4"
      type    = "A"
    },
    {
      name     = "${module.domain_com.domain}"
      value    = "mail.${module.domain_com.domain}"
      type     = "MX"
      priority = "10"
      proxied  = false
    },
  ]
}
```

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->
