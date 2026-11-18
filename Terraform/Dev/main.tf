#########################################
# VPC
#########################################

module "vpc" {

  source = "../Modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr = var.vpc_cidr
}

#########################################
# Subnets
#########################################

module "subnet" {

  source = "../Modules/subnets"

  vpc_id = module.vpc.vpc_id

  project_name = var.project_name
  environment  = var.environment

  public_subnet_1_aws = var.public_subnet_1_aws
  public_subnet_2_aws = var.public_subnet_2_aws
  public_subnet_3_aws = var.public_subnet_3_aws

  private_subnet_1_web = var.private_subnet_1_web
  private_subnet_2_web = var.private_subnet_2_web
  private_subnet_3_web = var.private_subnet_3_web

  private_subnet_1_app = var.private_subnet_1_app
  private_subnet_2_app = var.private_subnet_2_app
  private_subnet_3_app = var.private_subnet_3_app

  private_subnet_1_db = var.private_subnet_1_db
  private_subnet_2_db = var.private_subnet_2_db
  private_subnet_3_db = var.private_subnet_3_db


  az1 = var.az1
  az2 = var.az2
  az3 = var.az3
}

