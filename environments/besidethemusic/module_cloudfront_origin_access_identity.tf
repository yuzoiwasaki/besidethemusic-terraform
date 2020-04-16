variable "cloudfront_origin_access_identity_app" {
  type = map(string)

  default = {
    "default.comment" = "access-identity-besidethemusic"
  }
}

module "cloudfront_origin_access_identity_app" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//cloudfront_origin_access_identity"
  comment = "${lookup(
    var.cloudfront_origin_access_identity_app,
    "${terraform.workspace}.comment",
    var.cloudfront_origin_access_identity_app["default.comment"],
  )}-${terraform.workspace}-bucket"
}
