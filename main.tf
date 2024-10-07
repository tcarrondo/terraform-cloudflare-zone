# Zone creation
resource "cloudflare_zone" "domain" {
  count      = var.zone_on ? 1 : 0
  zone       = var.domain
  plan       = var.plan
  account_id = data.cloudflare_accounts.main.accounts[0].id
}

# Zone settings
resource "cloudflare_zone_settings_override" "domain" {
  zone_id = cloudflare_zone.domain[0].id

  depends_on = [cloudflare_zone.domain]

  settings {
    ssl                      = "full"
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    cache_level              = "aggressive"
    development_mode         = "off"
  }
}

# Naked A record
resource "cloudflare_record" "domain_ipv4" {
  count = length(var.ipv4)

  depends_on = [cloudflare_zone.domain]

  zone_id = cloudflare_zone.domain[0].id
  name    = var.domain
  content   = var.ipv4[count.index]
  proxied = "true"
  type    = "A"
}

# Naked AAAA record
resource "cloudflare_record" "domain_ipv6" {
  count = length(var.ipv6)

  depends_on = [cloudflare_zone.domain]

  zone_id = cloudflare_zone.domain[0].id
  name    = var.domain
  content  = var.ipv6[count.index]
  proxied = "true"
  type    = "AAAA"
}

# www > naked domain
resource "cloudflare_record" "domain_www" {
  count = length(var.ipv4)

  depends_on = [cloudflare_zone.domain]

  zone_id = cloudflare_zone.domain[0].id
  name    = "www"
  content  = var.www_cname == "" ? var.domain : var.www_cname
  proxied = "true"
  type    = "CNAME"
}

# Other A, CNAME, MX, TXT records
resource "cloudflare_record" "records" {

  for_each = local.final_records

  zone_id  = cloudflare_zone.domain[0].id
  name     = each.value.name
  content   = each.value.value
  type     = each.value.type
  priority = each.value.priority
  proxied  = each.value.proxied

  depends_on = [
    cloudflare_zone.domain
  ]
}
