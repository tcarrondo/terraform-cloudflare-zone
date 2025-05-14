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

output "all_name_servers" {
  value = merge(
    length(cloudflare_zone.domain) > 0 ? {
      (cloudflare_zone.domain[0].name) = cloudflare_zone.domain[0].name_servers
    } : {},
    {
      for alias_key, alias_zone in cloudflare_zone.alias :
      alias_zone.name => alias_zone.name_servers
    }
  )
}
