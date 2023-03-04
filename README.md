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
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | >= 3.32 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | >= 3.32 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_record.domain_ipv4](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.domain_ipv6](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.domain_www](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.records](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_zone.domain](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone) | resource |
| [cloudflare_zone_settings_override.domain](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override) | resource |
| [cloudflare_accounts.main](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/accounts) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | Cloudflare account name | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | Zone domain name | `string` | n/a | yes |
| <a name="input_ipv4"></a> [ipv4](#input\_ipv4) | Naked ipv4 (A) record value | `list(string)` | `[]` | no |
| <a name="input_ipv6"></a> [ipv6](#input\_ipv6) | Naked ipv6 (AAAA) record value | `list(string)` | `[]` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | Plan associated with the zone | `string` | `"free"` | no |
| <a name="input_records"></a> [records](#input\_records) | Other (A, CNAME, MX, TXT) records | `list(map(any))` | `[]` | no |
| <a name="input_zone_on"></a> [zone\_on](#input\_zone\_on) | Zone creation | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain"></a> [domain](#output\_domain) | Zone domain name |
| <a name="output_ns"></a> [ns](#output\_ns) | Zone nameservers |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | Zone ID |
<!-- END_TF_DOCS -->
