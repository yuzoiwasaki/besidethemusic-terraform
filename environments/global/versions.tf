terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.45.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.1.2"
    }
  }
  required_version = ">= 0.14"
}
