terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
    punycode = {
      source  = "henrikhorluck/punycode"
      version = "0.0.2"
    }
  }
  required_version = "~> 1"
}
