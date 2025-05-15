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
  version = "~> 4"
}

module "domain_com" {
  source  = "tcarrondo/zone/cloudflare"
  version = "~> 4"

  domain = "domain.com"

  ipv4 = ["1.2.3.4"]
  ipv6 = ["2607:f0d0:1002:51::4"]

  records = [
    {
      name    = "mail"
      value   = "1.2.3.4"
    },
    {
      name     = "${module.domain_com.domain}"
      value    = "mail.${module.domain_com.domain}"
      type     = "MX"
      priority = "10"
      proxied  = false
    }
  ]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_dns_record.alias_ipv4](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.alias_wildcard](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.domain_ipv4](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.domain_ipv6](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.domain_www](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.records](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_ruleset.redirect](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/ruleset) | resource |
| [cloudflare_zone.alias](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone) | resource |
| [cloudflare_zone.domain](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone) | resource |
| [cloudflare_zone_setting.alias](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_zone_setting.all](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_setting) | resource |
| [cloudflare_account.main](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | Cloudflare account name where the resources will be created. If not specified will use the first account, so it is recommended to be specified when your user has access to more then one account. | `string` | `""` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Zone domain name | `string` | n/a | yes |
| <a name="input_domain_alias"></a> [domain\_alias](#input\_domain\_alias) | Domain alias | `list(string)` | `[]` | no |
| <a name="input_ipv4"></a> [ipv4](#input\_ipv4) | Naked ipv4 (A) record value | `list(string)` | `[]` | no |
| <a name="input_ipv6"></a> [ipv6](#input\_ipv6) | Naked ipv6 (AAAA) record value | `list(string)` | `[]` | no |
| <a name="input_records"></a> [records](#input\_records) | Other (A, CNAME, MX, TXT) records | `list(map(any))` | `[]` | no |
| <a name="input_www_cname"></a> [www\_cname](#input\_www\_cname) | Custom www CNAME record value | `string` | `""` | no |
| <a name="input_zone_on"></a> [zone\_on](#input\_zone\_on) | Zone creation | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account"></a> [account](#output\_account) | Account |
| <a name="output_alias_zones"></a> [alias\_zones](#output\_alias\_zones) | Zone |
| <a name="output_all_name_servers"></a> [all\_name\_servers](#output\_all\_name\_servers) | n/a |
| <a name="output_zone"></a> [zone](#output\_zone) | Zone |
<!-- END_TF_DOCS -->
