variable "project" {
  description = "name of the project"
}

variable "environment" {
  description = "name of the environment"
}

variable "vpc_id" {
  description = "aws vps id"
}

variable "frontend_allowed_cidrs" {
  description = "frontend allowed cidrs for ecs service"
}

variable "backend_allowed_cidrs" {
  description = "backend allowed cidrs for ecs service"
}

variable "frontend_lb_allowed_cidrs" {
  description = "frontend load balancer allowed cidrs"
  type = list
}

variable "common_tags" {
  description = "common tags for all resources"
  type = map
}