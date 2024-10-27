# modules/rds/outputs.tf

output "rds_endpoint" {
  value = aws_rds_cluster.this.endpoint
}
