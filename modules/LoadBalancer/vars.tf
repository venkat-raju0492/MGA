variable "project" {
  description = "name of the project"
}

variable "environment" {
  description = "name of the environment"
}

variable "vpc_id" {
  description = "vpc id"
}

variable "deregistration_delay" {
  description = "deregistration delay"
}

variable "health_check_path" {
  description = "load balancer health check path"
}

variable "common_tags" {
  description = "common tags"
  type = map
}

variable "public_subnet_ids" {
  description = "public subnet ids"
  type = list
}

variable "frontend_lb_sg_id" {
  description = "frontend load balancer sg id"
}

variable "region" {
  description = "aws region"
}

variable "account_id" {
  description = "aws account id"
}

variable "certificate_arn_no" {
  description = "certificate arn no"
}