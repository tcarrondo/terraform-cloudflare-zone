locals {

  # DNS records default values
  record_defaults = {
    type     = "A"
    priority = null
    proxied  = true
  }

  # completed DNS records with (sort of) magic
  final_records = { for record in var.records :
    "${record.name}_${record.type}" => merge(local.record_defaults, record)
  }

}
