module "acm_certificate_besidethemusic_tokyo" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//acm_certificate?ref=v1.1.7"

  acm_region  = "us-east-1"
  domain_name = "besidethemusic.tokyo"

  tags = {
    "Environment" = terraform.workspace
    "Terraform"   = "true"
  }
}
