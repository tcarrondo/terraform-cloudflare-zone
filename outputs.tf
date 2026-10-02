# The provider marks cloudflare_zone's "permissions" and "plan" attributes as deprecated,
# so outputting the whole resource raises a "Deprecated value used" warning in every
# configuration that uses this module. Every other attribute is exposed explicitly.
output "zone" {
  description = "Zone (a list with one element, or empty when zone_on is false)"
  value = [for z in cloudflare_zone.domain : {
    account               = z.account
    activated_on          = z.activated_on
    cname_suffix          = z.cname_suffix
    created_on            = z.created_on
    development_mode      = z.development_mode
    id                    = z.id
    meta                  = z.meta
    modified_on           = z.modified_on
    name                  = z.name
    name_servers          = z.name_servers
    original_dnshost      = z.original_dnshost
    original_name_servers = z.original_name_servers
    original_registrar    = z.original_registrar
    owner                 = z.owner
    paused                = z.paused
    status                = z.status
    tenant                = z.tenant
    tenant_unit           = z.tenant_unit
    type                  = z.type
    vanity_name_servers   = z.vanity_name_servers
    verification_key      = z.verification_key
  }]
}

output "account" {
  description = "Account"
  value       = data.cloudflare_account.main
}

output "alias_zones" {
  description = "Alias zones, keyed by domain (same attributes as zone)"
  value = { for k, z in cloudflare_zone.alias : k => {
    account               = z.account
    activated_on          = z.activated_on
    cname_suffix          = z.cname_suffix
    created_on            = z.created_on
    development_mode      = z.development_mode
    id                    = z.id
    meta                  = z.meta
    modified_on           = z.modified_on
    name                  = z.name
    name_servers          = z.name_servers
    original_dnshost      = z.original_dnshost
    original_name_servers = z.original_name_servers
    original_registrar    = z.original_registrar
    owner                 = z.owner
    paused                = z.paused
    status                = z.status
    tenant                = z.tenant
    tenant_unit           = z.tenant_unit
    type                  = z.type
    vanity_name_servers   = z.vanity_name_servers
    verification_key      = z.verification_key
  } }
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
