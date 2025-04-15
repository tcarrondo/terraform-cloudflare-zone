# Zone creation
resource "cloudflare_zone" "domain" {
  count = var.zone_on ? 1 : 0
  name  = var.domain
  account = {
    id = data.cloudflare_account.main.account_id
  }
}

# Zone settings

locals {
  zone_settings = {
    ssl                      = "full"
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    cache_level              = "aggressive"
    development_mode         = "off"
  }
}

resource "cloudflare_zone_setting" "all" {
  for_each = local.zone_settings

  zone_id    = cloudflare_zone.domain[0].id
  setting_id = each.key
  id         = each.key
  value      = each.value

  depends_on = [
    cloudflare_zone.domain
  ]
}

# Naked A record
resource "cloudflare_dns_record" "domain_ipv4" {
  count = length(var.ipv4)


  zone_id = cloudflare_zone.domain[0].id
  name    = var.domain
  content = var.ipv4[count.index]
  proxied = "true"
  type    = "A"
  ttl     = 1

  depends_on = [
    cloudflare_zone.domain
  ]
}

# Naked AAAA record
resource "cloudflare_dns_record" "domain_ipv6" {
  count = length(var.ipv6)


  zone_id = cloudflare_zone.domain[0].id
  name    = var.domain
  content = var.ipv6[count.index]
  proxied = "true"
  type    = "AAAA"
  ttl     = 1

  depends_on = [
    cloudflare_zone.domain
  ]
}

# www > naked domain
resource "cloudflare_dns_record" "domain_www" {
  count = length(var.ipv4)


  zone_id = cloudflare_zone.domain[0].id
  name    = "www.${var.domain}"
  content = var.www_cname == "" ? var.domain : var.www_cname
  proxied = "true"
  type    = "CNAME"
  ttl     = 1

  depends_on = [
    cloudflare_zone.domain
  ]
}

# Other A, CNAME, MX, TXT records
resource "cloudflare_dns_record" "records" {

  for_each = local.final_records

  zone_id  = cloudflare_zone.domain[0].id
  name     = "${each.value.name}.${var.domain}"
  content  = each.value.value
  type     = each.value.type
  priority = each.value.priority
  proxied  = each.value.proxied
  ttl      = 1

  depends_on = [
    cloudflare_zone.domain
  ]
}
