variable "region" {
  description = "aws region"
}

variable "project" {
  description = "name of the project"
}

variable "environment" {
  description = "name of the environment"
}

variable "vpc_id" {
  description = "aws vpc id"
}

variable "frontend_allowed_cidrs" {
  description = "frontend allowed cidrs "
  type = list
}

variable "backend_allowed_cidrs" {
  description = "backend allowed cidrs"
}

variable "frontend_ecr_repo" {
  description = "frontend ecr repo"
}

variable "frontend_image_tag" {
  description = "frontend image tag"
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

variable "ecs_task_family_name" {
  description = "ecs task family name"
}

variable "ecs_launch_type" {
  description = "ecs launch type"
}

variable "ecs_frontend_scheduling_strategy" {
  description = "ecs frontend scheduling strategy"
}

variable "private_subnet_ids" {
  description = "private subnet ids"
  type = list
}

variable "backend_ecr_repo" {
  description = "backend ecr repo"
}

variable "backend_image_tag" {
  description = "backend container image tag"
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

variable "ecs_backend_scheduling_strategy" {
  description = "ecs backend scheduling strategy"
}