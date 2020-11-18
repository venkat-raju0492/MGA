variable "project" {
  description = "name of the project"
}

variable "waf_cidr_allowlist" {
  description = "cidr list to whitelist ips"
  type = list
}

variable "environment" {
  description = "name of the environment"
}
