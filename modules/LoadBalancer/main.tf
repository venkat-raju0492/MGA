resource "aws_alb_target_group" "alb-tg" {
  name                 = "${var.project}-frontend-alb-tg-${var.environment}"
  port                 = 80
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay

  health_check {
    path     = var.health_check_path
    protocol = "HTTP"
  }

  tags = merge(var.common_tags, map(
    "Name", "${var.project}-frontend-alb-tg-${var.environment}"
  ))

  depends_on = [aws_alb.alb]
}

resource "aws_alb" "alb" {
  name            = "${var.project}-frontend-alb-${var.environment}"
  subnets         = var.public_subnet_ids
  security_groups = var.frontend_lb_sg_id
  idle_timeout    = "300"

  tags = merge(var.common_tags, map(
    "Name", "${var.project}-frontend-alb-${var.environment}"
  ))
}

resource "aws_alb_listener" "alb-listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb-tg.id
    type             = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "alb-listener-https" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "arn:aws:acm:${var.region}:${var.account_id}:certificate/${var.certificate_arn_no}"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb-tg.arn
  }
}