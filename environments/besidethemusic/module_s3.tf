data "aws_iam_policy_document" "s3_app" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::besidethemusic-${terraform.workspace}/*"]

    principals {
      type        = "AWS"
      identifiers = [module.cloudfront_origin_access_identity_app.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::besidethemusic-${terraform.workspace}"]

    principals {
      type        = "AWS"
      identifiers = [module.cloudfront_origin_access_identity_app.iam_arn]
    }
  }
}

module "s3_app" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//s3"

  bucket = "besidethemusic-${terraform.workspace}"
  policy = data.aws_iam_policy_document.s3_app.json

  cors_rule = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["HEAD", "GET"]
      allowed_origins = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
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
