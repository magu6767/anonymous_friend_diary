# modules/vpc/variables.tf

variable "vpc_cidr_block" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "public_subnet_az" {
  type = string
}

variable "public_subnet_name" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "private_subnet_az" {
  type = string
}

variable "private_subnet_name" {
  type = string
}

variable "public_route_table_name" {
  type = string
}

variable "private_route_table_name" {
  type = string
}
