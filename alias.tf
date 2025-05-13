# Zone creation

resource "cloudflare_zone" "alias" {
  for_each = toset(var.domain_alias)
  name     = each.key
  account = {
    id = data.cloudflare_account.main.account_id
  }
}

# Zone settings

locals {
  alias_zone_settings = flatten([
    for domain in var.domain_alias : [
      for setting, value in local.zone_settings : {
        domain     = domain
        setting_id = setting
        value      = value
      }
    ]
  ])
}

resource "cloudflare_zone_setting" "alias" {
  for_each = {
    for item in local.alias_zone_settings :
    "${item.domain}.${item.setting_id}" => item
  }

  zone_id    = cloudflare_zone.alias[each.value.domain].id
  setting_id = each.value.setting_id
  id         = each.value.setting_id
  value      = each.value.value

  depends_on = [
    cloudflare_zone.alias
  ]
}

# Naked A record

resource "cloudflare_dns_record" "alias_ipv4" {
  for_each = toset(var.domain_alias)

  zone_id = cloudflare_zone.alias[each.key].id
  name    = each.key
  content = var.ipv4[0]
  proxied = "true"
  type    = "A"
  ttl     = 1

  depends_on = [
    cloudflare_zone.alias
  ]
}

# * record

resource "cloudflare_dns_record" "alias_wildcard" {
  for_each = toset(var.domain_alias)

  zone_id = cloudflare_zone.alias[each.key].id
  name    = "*.${each.key}"
  content = var.ipv4[0]
  proxied = "true"
  type    = "A"
  ttl     = 1

  depends_on = [
    cloudflare_zone.alias
  ]
}

# Redirect ruleset

resource "cloudflare_ruleset" "redirect" {
  for_each = toset(var.domain_alias)

  zone_id = cloudflare_zone.alias[each.key].id
  name    = "default"
  phase   = "http_request_dynamic_redirect"
  kind    = "zone"

  rules = [{
    description = "Redirect to ${var.domain}"
    expression  = true
    action      = "redirect"
    action_parameters = {
      from_value = {
        status_code = 301
        target_url = {
          expression = "concat(\"https://${var.domain}\", http.request.uri.path)"
        }
        preserve_query_string = true
      }
    }
  }]
}
