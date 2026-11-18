resource "aws_security_group" "Jump-Server" {

  name        = "${var.project_name}-${var.environment}-Jump-Server-sg"
  description = "Security Group for Jump-Server"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"

    from_port = 80
    to_port   = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins/Custom Port"

    from_port = 8080
    to_port   = 8080

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"

    from_port = 443
    to_port   = 443

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-Jump-Server-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}

#########################################
# Web Frontend ALB Security Group
#########################################
resource "aws_security_group" "web_frontend_alb" {

  name        = "${var.project_name}-${var.environment}-web-frontend-alb-sg"
  description = "Security Group for Web Frontend ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from Internet"

    from_port = 80
    to_port   = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-web-frontend-alb-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}

#########################################
# Web Server Security Group
#########################################
resource "aws_security_group" "web_srv" {

  name        = "${var.project_name}-${var.environment}-web-srv-sg"
  description = "Security Group for Web Server"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from Web Frontend ALB"

    from_port = 80
    to_port   = 80

    protocol = "tcp"

    security_groups = [aws_security_group.web_frontend_alb.id]
  }

  ingress {
    description = "SSH from Jump-Server"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    security_groups = [aws_security_group.Jump-Server.id]
  }

  egress {
    description = "Allow all outbound traffic"

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-web-srv-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}

#########################################
# App Internal ALB Security Group
#########################################
resource "aws_security_group" "app_internal_alb" {

  name        = "${var.project_name}-${var.environment}-app-internal-alb-sg"
  description = "Security Group for Internal App ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from Web Server"

    from_port = 80
    to_port   = 80

    protocol = "tcp"

    security_groups = [aws_security_group.web_srv.id]
  }

  egress {
    description = "Allow all outbound traffic"

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-app-internal-alb-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}

#########################################
# App Server Security Group
#########################################
resource "aws_security_group" "app_srv" {

  name        = "${var.project_name}-${var.environment}-app-srv-sg"
  description = "Security Group for App Server"
  vpc_id      = var.vpc_id

  ingress {
    description = "Custom TCP 4000 from Internal App ALB"

    from_port = 4000
    to_port   = 4000

    protocol = "tcp"

    security_groups = [aws_security_group.app_internal_alb.id]
  }

  ingress {
    description = "SSH from Jump-Server"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    security_groups = [aws_security_group.Jump-Server.id]
  }

  egress {
    description = "Allow all outbound traffic"

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-app-srv-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}

#########################################
# DB Server Security Group
#########################################
resource "aws_security_group" "db_srv" {

  name        = "${var.project_name}-${var.environment}-db-srv-sg"
  description = "Security Group for Database Server"
  vpc_id      = var.vpc_id

  ingress {
    description = "MySQL from App Server"

    from_port = 3306
    to_port   = 3306

    protocol = "tcp"

    security_groups = [aws_security_group.app_srv.id]
  }

  ingress {
    description = "SSH from Jump-Server"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    security_groups = [aws_security_group.Jump-Server.id]
  }

  egress {
    description = "Allow all outbound traffic"

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-db-srv-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}
