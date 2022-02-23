module "acm_certificate_validation_besidethemusic_tokyo" {
  source          = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//acm_certificate_validation?ref=v0.13.7"
  acm_region      = "us-east-1"
  certificate_arn = module.acm_certificate_besidethemusic_tokyo.acm_certificate_arn
  validation_record_fqdns = [
    module.route53_record_cloudfront_besidethemusic_tokyo_acm_1.route53_record_fqdn,
  ]
}
