module "route53_zone_app" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//route53_zone"
  name   = "besidethemusic.tokyo"
}
