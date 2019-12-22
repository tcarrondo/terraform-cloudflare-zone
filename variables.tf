# Zone settings
variable "domain" {}

variable "zone_on" {
  default = true
}

variable "plan" {
  default = "free"
}

# Naked A record
variable "ipv4" {
  type    = list(string)
  default = []
}

# Naked AAAA record
variable "ipv6" {
  type    = list(string)
  default = []
}

# Other A, CNAME, MX, TXT records
variable "records" {
  default = {}
}
