terraform {
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

locals {
  cloudfront_origin_access_identity = "access-identity-${var.project}-static-s3-${var.environment}.s3.amazonaws.com"
  fqdn = "S3-${var.project}-static-s3-${var.environment}"
  cname = ["${var.project}-static-s3-${var.environment}.${var.domain_name}"]
  s3bucket_domain_name = "${var.project}-static-s3-${var.environment}.s3.amazonaws.com"
  account_id = data.aws_caller_identity.current.account_id
  cert_arn = "arn:aws:acm:us-east-1:${local.account_id}:certificate/${var.cf_certificate_arn_no}"
  common_tags = {
    Project     = var.project
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

module "security" {
  source                    = "./modules/security/"
  project                   = var.project
  environment               = var.environment
  vpc_id                    = var.vpc_id
  frontend_allowed_cidrs    = var.frontend_allowed_cidrs
  backend_allowed_cidrs     = var.backend_allowed_cidrs
  frontend_lb_allowed_cidrs = var.frontend_lb_allowed_cidrs
  common_tags               = local.common_tags
}

module "WAF" {
  source                    = "./modules/WAF/"
  project                   = var.project
  environment               = var.environment
  waf_cidr_allowlist        = var.waf_cidr_allowlist
}

module "cloudfront" {
  source                            = "./modules/CloudFront/"
  bucket_regional_domain_name       = local.s3bucket_domain_name
  cloudfront_origin_access_identity = local.cloudfront_origin_access_identity
  fqdn                              = local.fqdn
  common_tags                       = local.common_tags
  project                           = var.project
  environment                       = var.environment
  cloudfront_default_certificate    = false
  aliases                           = local.cname
  cert_arn                          = local.cert_arn
  ssl_method                        = var.ssl_method
  protocol_version                  = var.protocol_version
  allow_methods                     = var.allow_methods
  cache_methods                     = var.cache_methods
  waf_acl_id                        = module.WAF.waf_acl_id
}

module "static-s3" {
  source                            = "./modules/S3/"
  environment                       = var.environment
  project                           = var.project
  s3_bucket                         = "static-s3"
  common_tags                       = local.common_tags
  expiration_days                   = var.static_s3_expiration_days
}

module "LoadBalancer" {
  source                    = "./modules/LoadBalancer/"
  project                   = var.project
  environment               = var.environment
  vpc_id                    = var.vpc_id
  frontend_lb_sg_id         = [module.security.frontend_lb_sg_id]
  deregistration_delay      = var.deregistration_delay
  health_check_path         = var.health_check_path
  public_subnet_ids         = var.public_subnet_ids
  region                    = var.region
  account_id                = data.aws_caller_identity.current.id
  certificate_arn_no        = var.certificate_arn_no
  common_tags               = local.common_tags
}

module "ECS" {
  source                           = "./modules/ECS/"
  project                          = var.project
  environment                      = var.environment
  account_id                       = data.aws_caller_identity.current.id
  common_tags                      = local.common_tags
  region                           = var.region
  frontend_lb_target_group_arn     = module.LoadBalancer.alb_target_group_arn
  frontend_ecr_repo                = var.frontend_ecr_repo
  frontend_image_tag               = var.frontend_image_tag
  frontend_memory                  = var.frontend_memory
  frontend_cpu                     = var.frontend_cpu
  frontend_container_port          = var.frontend_container_port
  ecs_frontend_desired_count       = var.ecs_frontend_desired_count
  ecs_backend_desired_count        = var.ecs_backend_desired_count
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

module "API-Gateway" {
  source                           = "./modules/API-Gateway/"
  project                          = var.project
  environment                      = var.environment
  common_tags                      = local.common_tags
}