module "route53_record_cloudfront_besidethemusic_tokyo_acm_1" {
  source  = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//route53_record?ref=v0.14.11"
  zone_id = module.route53_zone_app.route53_zone_id
  name = lookup(
    module.acm_certificate_besidethemusic_tokyo.acm_certificate_domain_validation_options[0],
    "resource_record_name"
  )
  type = lookup(
    module.acm_certificate_besidethemusic_tokyo.acm_certificate_domain_validation_options[0],
    "resource_record_type"
  )
  records = [lookup(
    module.acm_certificate_besidethemusic_tokyo.acm_certificate_domain_validation_options[0],
    "resource_record_value"
  )]
  ttl = 60
}
