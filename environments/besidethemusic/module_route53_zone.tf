module "route53_zone_app" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//route53_zone?ref=v0.15.5"
  name   = "besidethemusic.tokyo"
}
