terraform {
  backend "s3" {
    bucket = "aws-3tire-project"
    key    = "aws-3tire/terraform.tfstate"
    region = "ap-south-1"
  }
}
