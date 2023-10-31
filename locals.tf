locals {

  account_id = var.account_name == "" ? data.cloudflare_user.main[0].id : data.cloudflare_accounts.main[0].accounts[0].id

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
