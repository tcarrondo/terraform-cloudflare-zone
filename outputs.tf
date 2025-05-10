output "zone" {
  description = "Zone"
  value       = cloudflare_zone.domain
}

output "account" {
  description = "Account"
  value       = data.cloudflare_account.main
}

output "alias_zones" {
  description = "Zone"
  value       = cloudflare_zone.alias
}
