variable "environment" {
  description = "The name of the environment"
}

variable "project" {
  description = "The name of the project"
}

variable "s3_bucket" {
  description = "The name of the bucket."
}

variable "s3_acl_bucket" {
  description = "(Optional) The canned ACL to apply. Defaults to 'private'."
  default     = "private"
}

variable "s3_sse_algorithm" {
  description = "s3 service side encryption algorithm"
  default = "AES256"
}

variable "common_tags" {
  description = "(Optional) A mapping of tags to assign to the bucket."
  type        = map
}

variable "expiration_days" {
  description = "expiration days for life cycle policy"
  default = 90
}