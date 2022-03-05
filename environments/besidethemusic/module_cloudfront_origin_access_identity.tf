module "cloudfront_origin_access_identity_app" {
  source  = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//cloudfront_origin_access_identity?ref=v1.0.11"
  comment = "access-identity-besidethemusic-${terraform.workspace}-bucket"
}
