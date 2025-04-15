output "zone" {
  description = "Zone"
  value       = cloudflare_zone.domain
}

output "account" {
  description = "Account"
  value       = data.cloudflare_account.main
}
