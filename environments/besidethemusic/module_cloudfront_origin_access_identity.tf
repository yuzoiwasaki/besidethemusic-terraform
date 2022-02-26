module "cloudfront_origin_access_identity_app" {
  source  = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//cloudfront_origin_access_identity?ref=v0.14.11"
  comment = "access-identity-besidethemusic-${terraform.workspace}-bucket"
}
