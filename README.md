# cloudflare-zone
A Terraform module to create a domain zone in Cloudflare and add DNS the simpleway.
It creates:
* Zone;
* Zone settings;
* Naked A record, if provided;
* Naked AAAA record, if provided;
* WWW CNAME to naked;
* all additional records provided.

## Usage
```hcl
provider "cloudflare" {
  email   = ""
  api_key = ""
  version = "~> 2.2"
}

module "domain_com" {
  source  = "tcarrondo/zone/cloudflare"

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
