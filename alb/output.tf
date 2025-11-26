output "alb_sg" {
  description = "The security group ID of the ALB"
  value       = aws_security_group.lb_sg.id
}

output "target_group_arn" {
    description = "The ARN of the ALB target group"
    value       = aws_lb_target_group.my_app_tg.arn
}