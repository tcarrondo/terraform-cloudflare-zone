# Zone creation
resource "cloudflare_zone" "domain" {
  count = "${var.zone_on}"
  zone  = "${var.domain}"
  plan  = "${var.plan}"
}

# Zone settings
resource "cloudflare_zone_settings_override" "domain" {
  name = "${var.domain}"

  depends_on = ["cloudflare_zone.domain"]

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
  count = "${length(var.ipv4)}"

  depends_on = ["cloudflare_zone.domain"]

  domain  = "${var.domain}"
  name    = "${var.domain}"
  value   = "${var.ipv4[count.index]}"
  proxied = "true"
  type    = "A"
}

# Naked AAAA record
resource "cloudflare_record" "domain_ipv6" {
  count = "${length(var.ipv6)}"

  depends_on = ["cloudflare_zone.domain"]

  domain  = "${var.domain}"
  name    = "${var.domain}"
  value   = "${var.ipv6[count.index]}"
  proxied = "true"
  type    = "AAAA"
}

# www > naked domain
resource "cloudflare_record" "domain_www" {
  count = "${length(var.ipv4)}"

  depends_on = ["cloudflare_zone.domain"]

  domain  = "${var.domain}"
  name    = "www"
  value   = "${var.domain}"
  proxied = "true"
  type    = "CNAME"
}

# Other A, CNAME, MX, TXT records
resource "cloudflare_record" "records" {
  count = "${length(var.records)}"

  depends_on = ["cloudflare_zone.domain"]

  domain   = "${var.domain}"
  name     = "${lookup(var.records[count.index], "name" )}"
  value    = "${lookup(var.records[count.index], "value" )}"
  type     = "${lookup(var.records[count.index], "type", "A" )}"
  priority = "${lookup(var.records[count.index], "priority", 0)}"
  proxied  = "${lookup(var.records[count.index], "proxied", true )}"
}
