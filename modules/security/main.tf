resource "aws_security_group" "ecs_frontend_sg" {
  name   = "${var.project}-ecs-frontend-sg-${var.environment}"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.frontend_allowed_cidrs
  }

  tags = merge(var.common_tags, map(
    "Name", "${var.project}-ecs-frontend-sg-${var.environment}"
  ))
}

resource "aws_security_group" "ecs_backend_sg" {
  name   = "${var.project}-ecs-backend-sg-${var.environment}"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.backend_allowed_cidrs
  }

  tags = merge(var.common_tags, map(
    "Name", "${var.project}-ecs-backend-sg-${var.environment}"
  ))
}

resource "aws_iam_role" "ecs_frontend_task_role" {
  name = "${var.project}-ecs-frontend-role-${var.environment}"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
            "Service": [
                "ecs-tasks.amazonaws.com"
            ]
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
  tags = merge(var.common_tags, map(
    "Name", "${var.project}-ecs-frontend-role-${var.environment}"
  ))
}

resource "aws_iam_role" "ecs_backend_task_role" {
  name = "${var.project}-ecs-backend-role-${var.environment}"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
            "Service": [
                "ecs-tasks.amazonaws.com"
            ]
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
  tags = merge(var.common_tags, map(
    "Name", "${var.project}-ecs-backend-role-${var.environment}"
  ))
}