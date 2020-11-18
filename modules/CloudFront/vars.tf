variable "cloudfront_origin_access_identity" {
  description = "cloudfront origin access identity"
}

variable "bucket_regional_domain_name" {
  description = "name of domain name for the origin"
}

variable "fqdn" {
  description = "name of the origin ID"
}

variable "common_tags" {
  description = "common tags to map"
  type        = map(string)
}

variable "project" {
  description = "Name of the project"
}

variable "environment" {
  description = "The name of the environment"
}

variable "waf_acl_id" {
  description = "waf acl id to restrict cloudfront"
}

variable "aliases" {
  description = "altername domain cnames"
  type        = list(string)
  default     = null
}

variable "cloudfront_default_certificate" {
  description = "cloudfront_default_certificate"
  default = false
}

variable "cert_arn" {
  description = "certificate arn"
  default = null
}

variable "ssl_method" {
  description = "ssl support method"
  default = null
}

variable "protocol_version" {
  description = "minimum protocol version"
  default = null
}

variable "object_file" {
  description = "default root object"
  default     = "index.html"
}

variable "allow_methods" {
  description = "default cache behaviour allowed methods"
  type        = list(string)
}

variable "cache_methods" {
  description = "default cache behaviour cached methods"
  type        = list(string)
}

variable "min_ttl" {
  description = "default cache behaviour minimum ttl"
  default     = 0
}

variable "default_ttl" {
  description = "default cache behaviour default ttl"
  default     = 86400
}

variable "max_ttl" {
  description = "default cache behaviour maximum ttl"
  default     = 31536000
}

variable "protocol_policy" {
  description = "default cache behaviour viewer protocol policy"
  default     = "allow-all"
}

variable "error_ttl" {
  description = "custom error response error caching minimum ttl"
  default     = "300"
}

variable "error_code" {
  description = "custom error response caching error code"
  default     = "404"
}

variable "response_code" {
  description = "custom error response caching response code"
  default     = "200"
}

variable "response_path" {
  description = "custom error response caching response page path"
  default     = "/index.html"
}
