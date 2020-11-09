resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project}-ecs-cluster-${var.environment}"
}

resource "aws_cloudwatch_log_group" "frontned_log_group" {
  name              = "${var.project}-ecs-frontend-lg-${var.environment}"
  retention_in_days = 30

  tags = "${merge(var.common_tags, map(
    "Name", "${var.project}-${var.environment}-ecs-loggroup-frontend"
  ))}"
}

data "template_file" "ecs_frontned_template" {
  template = "${file("modules/ECS/task-definitions/frontend.json")}"

  vars {
    account_id = var.account_id
    project = var.project
    region = var.region
    frontend_ecr_repo = var.frontend_ecr_repo
    frontend_image_tag = var.frontend_image_tag
    frontend_memory = var.frontend_memory
    frontend_cpu = var.frontend_cpu
    frontend_container_port = var.frontend_container_port
    cloudwatch_logs_group = aws_cloudwatch_log_group.frontned_log_group.name_prefix

  }
}

resource "aws_ecs_task_definition" "application_ecs_frontend_task_definition" {
  family                   = var.ecs_task_family_name
  execution_role_arn       = var.ecs_frontend_role_arn
  task_role_arn            = var.ecs_frontend_role_arn
  network_mode             = "bridge"
  requires_compatibilities = [var.ecs_launch_type]
  cpu                      = var.frontend_cpu
  memory                   = var.frontend_memory
  container_definitions    = data.template_file.ecs_frontned_template

  tags = merge(
    var.common_tags,
    {
      "Name" = "${var.project}-ecs_frontend_task_definition-${environment}"
    },
  )
}

resource "aws_ecs_service" "application_ecs_frontend_service" {
  name                = "${var.project}-ecs-frontend-service-${var.environment}"
  cluster             = aws_ecs_cluster.ecs_cluster.id
  task_definition     = aws_ecs_task_definition.application_ecs_frontend_task_definition.arn
  launch_type         = var.ecs_launch_type
  scheduling_strategy = var.ecs_frontend_scheduling_strategy

  network_configuration {
    security_groups  = [var.frontend_security_group]
    subnets          = var.private_subnet_ids
    assign_public_ip = false
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_cloudwatch_log_group" "backned_log_group" {
  name              = "${var.project}-ecs-backend-lg-${var.environment}"
  retention_in_days = 30

  tags = "${merge(var.common_tags, map(
    "Name", "${var.project}-${var.environment}-ecs-loggroup-backend"
  ))}"
}

data "template_file" "ecs_backend_template" {
  template = "${file("modules/ECS/task-definitions/backend.json")}"

  vars {
    account_id = var.account_id
    project = var.project
    region = var.region
    frontend_ecr_repo = var.backend_ecr_repo
    frontend_image_tag = var.backend_image_tag
    frontend_memory = var.backend_memory
    frontend_cpu = var.backend_cpu
    frontend_container_port = var.backend_container_port
    cloudwatch_logs_group = aws_cloudwatch_log_group.backned_log_group.name_prefix

  }
}

resource "aws_ecs_task_definition" "application_ecs_backend_task_definition" {
  family = var.ecs_task_family_name
  execution_role_arn       = var.ecs_backend_role_arn
  task_role_arn            = var.ecs_backend_role_arn
  network_mode = "bridge"
  requires_compatibilities = [var.ecs_launch_type]
  cpu = var.frontend_cpu
  memory = var.frontend_memory
  container_definitions = data.template_file.ecs_frontned_template

  tags = merge(
  var.common_tags,
  {
    "Name" = "${var.project}-ecs_backend_task_definition-${environment}"
  },
  )
}


resource "aws_ecs_service" "application_ecs_backend_service" {
  name                = "${var.project}-ecs-backend-service-${var.environment}"
  cluster             = aws_ecs_cluster.ecs_cluster.id
  task_definition     = aws_ecs_task_definition.application_ecs_backend_task_definition.arn
  launch_type         = var.ecs_launch_type
  scheduling_strategy = var.ecs_backend_scheduling_strategy

  network_configuration {
    security_groups  = [var.backend_security_group]
    subnets          = var.private_subnet_ids
    assign_public_ip = false
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}


