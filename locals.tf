locals {

  # DNS records default values
  record_defaults = {
    type     = "A"
    priority = "0"
    proxied  = true
  }

  # completed DNS records with (sort of) magic
  final_records = { for k, v in var.records :
    k => merge(local.record_defaults, v)
  }

}
