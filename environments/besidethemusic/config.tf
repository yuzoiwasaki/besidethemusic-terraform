provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  backend "s3" {
    bucket = "besidethemusic-terraform-backend"
    key    = "besidethemusic/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
