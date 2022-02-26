module "acm_certificate_besidethemusic_tokyo" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//acm_certificate?ref=v0.14.11"

  acm_region  = "us-east-1"
  domain_name = "besidethemusic.tokyo"

  tags = {
    "Environment" = terraform.workspace
    "Terraform"   = "true"
  }
}
