variable "account_name" {
  description = "Cloudflare account name where the resources will be created. If not specified will use the first account, so it is recommended to be specified when your user has access to more then one account."
  type        = string
  default     = ""
}

variable "domain" {
  description = "Zone domain name"
  type        = string
}

variable "zone_on" {
  description = "Zone creation"
  type        = bool
  default     = true
}

variable "plan" {
  description = "Plan associated with the zone"
  type        = string
  default     = "free"
}

variable "ipv4" {
  description = "Naked ipv4 (A) record value"
  type        = list(string)
  default     = []
}

variable "ipv6" {
  description = "Naked ipv6 (AAAA) record value"
  type        = list(string)
  default     = []
}

variable "www_cname" {
  description = "Custom www CNAME record value"
  type        = string
  default     = ""
}

variable "records" {
  description = "Other (A, CNAME, MX, TXT) records"
  type        = list(map(any))
  default     = []
}
