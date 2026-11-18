variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_1_aws" {
  type = string
}

variable "public_subnet_2_aws" {
  type = string
}
variable "public_subnet_3_aws" {
  type = string
}

variable "private_subnet_1_web" {
  type = string
}

variable "private_subnet_2_web" {
  type = string
}
variable "private_subnet_3_web" {
  type = string
}

variable "private_subnet_1_app" {
  type = string
}

variable "private_subnet_2_app" {
  type = string
}
variable "private_subnet_3_app" {
  type = string
}

variable "private_subnet_1_db" {
  type = string
}

variable "private_subnet_2_db" {
  type = string
}
variable "private_subnet_3_db" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "az1" {}

variable "az2" {}

variable "az3" {}
