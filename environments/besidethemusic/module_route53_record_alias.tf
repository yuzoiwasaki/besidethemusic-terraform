variable "route53_zone_alias_besidethemusic_tokyo_cloudfront" {
  type = map(string)

  default = {
    "default.name"        = "besidethemusic.tokyo"
    "default.domain_name" = "d340wkke3eba05.cloudfront.net"
  }
}

module "route53_record_alias_besidethemusic_tokyo_cloudfront" {
  source  = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//route53_record_alias"
  zone_id = module.route53_zone_app.route53_zone_id
  name = lookup(
    var.route53_zone_alias_besidethemusic_tokyo_cloudfront,
    "${terraform.workspace}.name",
    var.route53_zone_alias_besidethemusic_tokyo_cloudfront["default.name"],
  )
  alias_name = lookup(
    var.route53_zone_alias_besidethemusic_tokyo_cloudfront,
    "${terraform.workspace}.domain_name",
    var.route53_zone_alias_besidethemusic_tokyo_cloudfront["default.domain_name"],
  )
  alias_zone_id = "Z2FDTNDATAQYW2"
}
