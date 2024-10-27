variable "ec2_sg_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "volume_type" {
  type = string
}

variable "volume_size" {
  type = number
}

variable "iops" {
  type = number
}

variable "ec2_name" {
  type = string
}

variable "target_group_arn" {
  type = string
}
