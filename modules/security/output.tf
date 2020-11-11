output "frontend_sg_id" {
  value = aws_security_group.ecs_frontend_sg.id
}

output "backend_sg_id" {
  value = aws_security_group.ecs_backend_sg.id
}

output "frontend_role_arn" {
  value = aws_iam_role.ecs_frontend_task_role.arn
}

output "backend_role_arn" {
  value = aws_iam_role.ecs_backend_task_role.arn
}

output "frontend_lb_sg_id" {
  value = aws_security_group.frontend-lb-sg.id
}