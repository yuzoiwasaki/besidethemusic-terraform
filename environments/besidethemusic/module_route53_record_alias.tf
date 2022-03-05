module "route53_record_alias_besidethemusic_tokyo_cloudfront" {
  source        = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//route53_record_alias?ref=v1.0.11"
  zone_id       = module.route53_zone_app.route53_zone_id
  name          = "besidethemusic.tokyo"
  alias_name    = "d340wkke3eba05.cloudfront.net"
  alias_zone_id = "Z2FDTNDATAQYW2"
}
