# modules/ec2/outputs.tf

output "ec2_instance_id" {
  value = aws_instance.this.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}
