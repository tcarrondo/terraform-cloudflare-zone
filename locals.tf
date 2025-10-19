locals {

  # DNS records default values
  record_defaults = {
    type     = "A"
    priority = null
    proxied  = true
  }

  # Use ... to group duplicates (creates list of records)
  grouped_records = { for record in var.records :
    "${record.name}_${record.type}" => merge(local.record_defaults, record)...
  }

  # Flatten to create individual records
  final_records = merge([
    for key, records in local.grouped_records : {
      for idx, record in records :
      "${key}_${idx}" => record
    }
  ]...)

}
