module "cloudfront_origin_access_identity_app" {
  source  = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//cloudfront_origin_access_identity"
  comment = "access-identity-besidethemusic-${terraform.workspace}-bucket"
}
