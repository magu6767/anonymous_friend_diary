# modules/rds/variables.tf

variable "subnet_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "rds_sg_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ec2_sg_id" {
  type = string
}

variable "cluster_identifier" {
  type = string
}

variable "database_name" {
  type = string
}

variable "master_username" {
  type = string
}

variable "master_password" {
  type      = string
  sensitive = true
}

variable "cluster_name" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "instance_identifier" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "instance_name" {
  type = string
}
