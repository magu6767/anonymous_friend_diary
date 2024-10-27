# modules/alb/variables.tf

variable "alb_sg_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "alb_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "target_group_name" {
  type = string
}

variable "ssl_policy" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "listener_name" {
  type = string
}
