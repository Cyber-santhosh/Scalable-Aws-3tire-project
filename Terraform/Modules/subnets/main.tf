resource "aws_subnet" "public_subnet_1_aws" {

  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_1_aws
  availability_zone       = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2_aws" {

  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_2_aws
  availability_zone       = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet-2"
  }
}

resource "aws_subnet" "public_subnet_3_aws" {

  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_3_aws
  availability_zone       = var.az3
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet-3"
  }
}

resource "aws_subnet" "private_subnet_1_app" {

  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_1_app
  availability_zone       = var.az1
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-app-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2_app" {

  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_2_app
  availability_zone       = var.az2
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-app-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_3_app" {

  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_3_app
  availability_zone       = var.az3
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-app-subnet-3"
  }
}

resource "aws_subnet" "private_subnet_1_web" {

  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_1_web
  availability_zone       = var.az1
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-web-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2_web" {

  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_2_web
  availability_zone       = var.az2
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-web-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_3_web" {

  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_3_web
  availability_zone       = var.az3
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-web-subnet-3"
  }
}

resource "aws_subnet" "private_subnet_1_db" {

  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_1_db
  availability_zone       = var.az1
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-db-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2_db" {

  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_2_db
  availability_zone       = var.az2
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-db-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_3_db" {

  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_3_db
  availability_zone       = var.az3
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-db-subnet-3"
  }
}