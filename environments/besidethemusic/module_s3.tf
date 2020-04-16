#####################################
# For app
#####################################
## Set variables
variable "s3_app" {
  type = map(string)

  default = {
    "default.bucket"                    = "besidethemusic"
    "default.cors_rule_allowed_headers" = "*"
    "default.cors_rule_allowed_methods" = "HEAD,GET"
    "default.cors_rule_allowed_origins" = "*"
    "default.cors_rule_expose_headers"  = "ETag"
    "default.cors_rule_max_age_seconds" = 3000
  }
}

# data "aws_iam_policy_document" "s3_app" {
#   statement {
#     actions = ["s3:GetObject"]
#     resources = ["arn:aws:s3:::${lookup(
#       var.s3_app,
#       "${terraform.workspace}.bucket",
#       var.s3_app["default.bucket"],
#     )}-${terraform.workspace}/*"]
#   }
#
#   principals {
#     type = "AWS"
#     identifiers = [module.cloudfront_origin_access_identity_app.iam_arn]
#   }
#
#   statement {
#     actions = ["s3:ListBucket"]
#     resources = ["arn:aws:s3:::${lookup(
#       var.s3_app,
#       "${terraform.workspace}.bucket",
#       var.s3_app["default.bucket"],
#     )}-${terraform.workspace}"]
#   }
#
#   principals {
#     type = "AWS"
#     identifiers = [module.cloudfront_origin_access_identity_app.iam_arn]
#   }
# }

## Run modules
module "s3_app" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//s3"

  bucket = "${lookup(
    var.s3_app,
    "${terraform.workspace}.bucket",
    var.s3_app["default.bucket"],
  )}-${terraform.workspace}"
  #policy = data.aws_iam_policy_document.s3_app.json

  cors_rule = [
    {
      allowed_headers = split(
        ",",
        lookup(
          var.s3_app,
          "${terraform.workspace}.cors_rule_allowed_headers",
          var.s3_app["default.cors_rule_allowed_headers"],
        ),
      )
      allowed_methods = split(
        ",",
        lookup(
          var.s3_app,
          "${terraform.workspace}.cors_rule_allowed_methods",
          var.s3_app["default.cors_rule_allowed_methods"],
        ),
      )
      allowed_origins = split(
        ",",
        lookup(
          var.s3_app,
          "${terraform.workspace}.cors_rule_allowed_origins",
          var.s3_app["default.cors_rule_allowed_origins"],
        ),
      )
      expose_headers = split(
        ",",
        lookup(
          var.s3_app,
          "${terraform.workspace}.cors_rule_expose_headers",
          var.s3_app["default.cors_rule_expose_headers"],
        ),
      )
      max_age_seconds = lookup(
        var.s3_app,
        "${terraform.workspace}.cors_rule_max_age_seconds",
        var.s3_app["default.cors_rule_max_age_seconds"],
      )
    },
  ]

  website = [
    {
      index_document = "index.html"
      error_document = "404.html"
    },
  ]

  tags = {
    "Environment" = terraform.workspace
    "Terraform"   = "true"
  }
}
