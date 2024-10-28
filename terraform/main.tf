# main.tf

provider "aws" {
  region = "ap-northeast-1"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = "172.30.0.0/18"
  vpc_name       = "dpp-system-prod-vpc"
  igw_name       = "DPP_IGW"

  public_subnet_cidr = "172.30.2.0/24"
  public_subnet_az   = "ap-northeast-1c"
  public_subnet_name = "dpp-system-public-subnet-1c"

  private_subnet_cidr = "172.30.3.0/24"
  private_subnet_az   = "ap-northeast-1c"
  private_subnet_name = "dpp-system-private-subnet-1c"

  public_route_table_name  = "dpp-system-public-subnet-rtb"
  private_route_table_name = "dpp-system-private-subnet-rtb"
}

module "ec2" {
  source = "./modules/ec2"

  ec2_sg_name = "dpp-system-web-sg"
  vpc_id      = module.vpc.vpc_id
  alb_sg_id   = module.alb.alb_sg_id

  ami_id        = "ami-03f584e50b2d32776"
  instance_type = "t3a.medium"
  subnet_id     = module.vpc.public_subnet_id
  key_name      = "dpp-key"

  volume_type = "gp3"
  volume_size = 100
  iops        = 3000

  ec2_name = "DPP_EC2_Instance"

  target_group_arn = module.alb.target_group_arn
}

module "acm" {
  source = "./modules/acm"

  domain_name = "anonymous-friend-diary.com"
  route53_zone_id = "Z09253851VU9A9DWELC1J"
}

module "alb" {
  source = "./modules/alb"

  alb_sg_name = "dpp-system-elb-sg"
  vpc_id      = module.vpc.vpc_id

  alb_name   = "dpp-alb"
  subnet_id  = module.vpc.public_subnet_id

  target_group_name = "dpp-target-group"

  ssl_policy     = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn = aws_acm_certificate.dpp_cert.arn

  listener_name = "DPP_ALB_Listener"
}

module "rds" {
  source = "./modules/rds"

  subnet_group_name = "dpp-aurora-subnet-group"
  subnet_id         = module.vpc.private_subnet_id
  rds_sg_name       = "dpp-system-db-sg"
  vpc_id            = module.vpc.vpc_id
  ec2_sg_id         = module.ec2.ec2_sg_id

  cluster_identifier = "dpp-aurora-cluster"
  database_name      = "dpp"
  master_username    = "admin"
  master_password    = "password"  # ここは変数化またはSecret Managerの使用を推奨

  cluster_name = "DPP_Aurora_Cluster"

  instance_count      = 2
  instance_identifier = "dpp-aurora-instance"
  instance_class      = "db.r5.large"
  instance_name       = "DPP_Aurora_Instance"
}
