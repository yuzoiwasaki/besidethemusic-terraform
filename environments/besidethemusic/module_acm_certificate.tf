#####################################
# For besidethemusic.tokyo cloudfront
#####################################
## Set variables
variable "acm_certificate_besidethemusic_tokyo" {
  type = map(string)

  default = {
    "default.acm_region"  = "us-east-1"
    "default.domain_name" = "besidethemusic.tokyo"
  }
}

## Run module
module "acm_certificate_besidethemusic_tokyo" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//acm_certificate"

  acm_region = lookup(
    var.acm_certificate_besidethemusic_tokyo,
    "${terraform.workspace}.acm_region",
    var.acm_certificate_besidethemusic_tokyo["default.acm_region"],
  )

  domain_name = lookup(
    var.acm_certificate_besidethemusic_tokyo,
    "${terraform.workspace}.domain_name",
    var.acm_certificate_besidethemusic_tokyo["default.domain_name"],
  )

  tags = {
    "Environment" = terraform.workspace
    "Terraform"   = "true"
  }
}
