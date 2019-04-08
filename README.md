# cloudflare-zone
A Terraform module to create a domain in Cloudflare and add DNS the simpleway.

## Usage
```hcl
module "domain_com" {
  source = "github.com/tcarrondo/cloudflare-zone"

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
