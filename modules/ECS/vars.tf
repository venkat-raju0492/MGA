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

variable "account_id" {
  description = "aws account id"
}

variable "region" {
  description = "aws region"
}

variable "frontend_ecr_repo" {
  description = "frontend ecr repo"
}

variable "frontend_image_tag" {
  description = "frontend ecr image tag"
}

variable "frontend_memory" {
  description = "frontend container memory"
}

variable "frontend_cpu" {
  description = "frontend container cpu"
}

variable "frontend_container_port" {
  description = "frontend container port"
}

variable "ecs_frontend_role_arn" {
  description = "ecs task definition iam role arn for frontend"
}

variable "ecs_frontend_desired_count" {
  description = "ecs frontend desired no. of containers"
}

variable "ecs_backend_role_arn" {
  description = "ecs task definiton iam role arn for backend"
}

variable "ecs_launch_type" {
  description = "ecs launch type"
}

variable "ecs_frontend_scheduling_strategy" {
  description = "ecs frontend service scheduling strategy"
}

variable "frontend_lb_target_group_arn" {
  description = "frontend lb target group arn"
}

variable "frontend_security_group" {
  description = "frontend servide security group id"
}

variable "private_subnet_ids" {
  description = "vpc private subnet ids"
  type = list
}

variable "backend_ecr_repo" {
  description = "backend ecr repo"
}

variable "backend_image_tag" {
  description = "backend image ecr tag"
}

variable "backend_memory" {
  description = "backend container memory"
}

variable "backend_cpu" {
  description = "backend container cpu"
}

variable "backend_container_port" {
  description = "backend container port"
}

variable "ecs_backend_desired_count" {
  description = "ecs backend desired no. of containers"
}

variable "ecs_backend_scheduling_strategy" {
  description = "backend service scheduling strategy"
}

variable "backend_security_group" {
  description = "backend security group id"
}

