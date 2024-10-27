# modules/alb/outputs.tf

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "alb_arn" {
  value = aws_lb.this.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}
