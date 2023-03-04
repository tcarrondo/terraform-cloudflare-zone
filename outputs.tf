output "domain" {
  description = "Zone domain name"
  value       = var.domain
}

output "ns" {
  description = "Zone nameservers"
  value       = cloudflare_zone.domain.0.name_servers
}

output "zone_id" {
  description = "Zone ID"
  value       = cloudflare_zone.domain.0.id
}
