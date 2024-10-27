# modules/rds/main.tf

resource "aws_db_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = [var.subnet_id]

  tags = {
    Name = var.subnet_group_name
  }
}

resource "aws_security_group" "rds_sg" {
  name   = var.rds_sg_name
  vpc_id = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.rds_sg_name
  }
}

resource "aws_rds_cluster" "this" {
  cluster_identifier      = var.cluster_identifier
  engine                  = "aurora-mysql"
  engine_version          = "8.0"
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.this.name

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_rds_cluster_instance" "instances" {
  count              = var.instance_count
  identifier         = "${var.instance_identifier}-${count.index}"
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.this.engine

  tags = {
    Name = "${var.instance_name}-${count.index}"
  }
}
