provider "aws" {
  version = "~> 2.45.0"
  region  = "ap-northeast-1"
}

provider "template" {
  version = "~> 2.1.2"
}

terraform {
  backend "s3" {
    bucket = "besidethemusic-terraform-backend"
    key    = "besidethemusic-global/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
