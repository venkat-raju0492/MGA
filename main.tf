provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

locals {
  common_tags = {
    Project = var.project
    Environment = var.environment
    CreatedBy = "Terraform"
  }
}

module "security" {
  source                 = "./modules/security/"
  project                = var.project
  environment            = var.environment
  vpc_id                 = var.vpc_id
  frontend_allowed_cidrs = var.frontend_allowed_cidrs
  backend_allowed_cidrs  = var.backend_allowed_cidrs
  common_tags            = local.common_tags
}

module "ECS" {
  source                           = "./modules/ECS/"
  project                          = var.project
  environment                      = var.environment
  account_id                       = data.aws_caller_identity.current.id
  common_tags                      = local.common_tags
  region                           = var.region
  frontend_ecr_repo                = var.frontend_ecr_repo
  frontend_image_tag               = var.frontend_image_tag
  frontend_memory                  = var.frontend_memory
  frontend_cpu                     = var.frontend_cpu
  frontend_container_port          = var.frontend_container_port
  ecs_task_family_name             = var.ecs_task_family_name
  ecs_frontend_role_arn            = module.security.frontend_role_arn
  ecs_launch_type                  = var.ecs_launch_type
  ecs_backend_role_arn             = module.security.backend_role_arn
  ecs_frontend_scheduling_strategy = var.ecs_frontend_scheduling_strategy
  frontend_security_group          = module.security.frontend_sg_id
  private_subnet_ids               = var.private_subnet_ids
  backend_ecr_repo                 = var.backend_ecr_repo
  backend_image_tag                = var.backend_image_tag
  backend_memory                   = var.backend_memory
  backend_cpu                      = var.backend_cpu
  backend_container_port           = var.backend_container_port
  ecs_backend_scheduling_strategy  = var.ecs_backend_scheduling_strategy
  backend_security_group           = module.security.backend_sg_id
}