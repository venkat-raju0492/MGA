variable "project" {
  description = "name of the project"
}

variable "environment" {
  description = "name of the environment"
}

variable "common_tags" {
  description = "common tags for all resources"
  type = map
}