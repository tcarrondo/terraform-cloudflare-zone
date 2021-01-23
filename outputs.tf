output "domain" {
  value = var.domain
}

output "ns" {
  value = cloudflare_zone.domain.0.name_servers
}

output "zone_id" {
  value = cloudflare_zone.domain.0.id
}
