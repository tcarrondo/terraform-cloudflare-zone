variable "account_name" {
  description = "Cloudflare account name"
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


variable "records" {
  description = "Other (A, CNAME, MX, TXT) records"
  type        = list(map(any))
  default     = []
}
