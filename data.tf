data "cloudflare_accounts" "main" {
  count = var.account_name != "" ? 1 : 0

  name = var.account_name
}
