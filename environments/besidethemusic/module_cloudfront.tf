locals {
  cloudfront_base_custom_origin_config = {
    http_port              = 80
    https_port             = 443
    origin_protocol_policy = "https-only"
    origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
  }
}

#####################################
# For app
#####################################
## Set variables
variable "cloudfront_app" {
  type = map(string)

  default = {
    "default.comment"                        = "besidethemusic.tokyo"
    "default.aliases"                        = "besidethemusic.tokyo"
    "default.certificate_arn"                = "arn:aws:acm:us-east-1:192619379047:certificate/e90bb546-4813-4cef-b838-c41380d3a3e3"
    "default.default_origin_id"              = "besidethemusic-production"
    "default.default_origin_domain_name"     = "besidethemusic-production.s3-website-ap-northeast-1.amazonaws.com"
    "default.default_origin_protocol_policy" = "http-only"
    "default.default_origin_read_timeout"    = 60
    "default.ssl_support_method"             = "sni-only"
  }
}

# Run modules
module "cloudfront_app" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//cloudfront"

  comment = lookup(
    var.cloudfront_app,
    "${terraform.workspace}.comment",
    var.cloudfront_app["default.comment"],
  )
  aliases = split(
    ",",
    lookup(
      var.cloudfront_app,
      "${terraform.workspace}.aliases",
      var.cloudfront_app["default.aliases"],
    ),
  )

  default_root_object = "index.html"

  origins = [
    {
      domain_name = lookup(
        var.cloudfront_app,
        "${terraform.workspace}.default_origin_domain_name",
        var.cloudfront_app["default.default_origin_domain_name"],
      )
      origin_id = lookup(
        var.cloudfront_app,
        "${terraform.workspace}.default_origin_id",
        var.cloudfront_app["default.default_origin_id"],
      )
      custom_origin_config = [
        merge(
          local.cloudfront_base_custom_origin_config,
          {
            "origin_protocol_policy" = lookup(
              var.cloudfront_app,
              "${terraform.workspace}.default_origin_protocol_policy",
              var.cloudfront_app["default.default_origin_protocol_policy"],
            )
          },
          {
            "origin_read_timeout" = lookup(
              var.cloudfront_app,
              "${terraform.workspace}.default_origin_read_timeout",
              var.cloudfront_app["default.default_origin_read_timeout"],
            )
          },
        ),
      ]
    },
  ]

  custom_error_response = [
    {
      error_code            = "404"
      error_caching_min_ttl = "360"
      response_code         = "200"
      response_page_path    = "/"
    },
  ]

  default_cache_behavior = [
    {
      allowed_methods = ["GET", "HEAD"]
      cached_methods  = ["GET", "HEAD"]
      target_origin_id = lookup(
        var.cloudfront_app,
        "${terraform.workspace}.default_origin_id",
        var.cloudfront_app["default.default_origin_id"],
      )
      compress = true
      forwarded_values = [
        {
          query_string = false
          headers      = ["Origin"]
          cookies = [
            {
              forward = "none"
            },
          ]
        },
      ]
      viewer_protocol_policy = "redirect-to-https"
      min_ttl                = 0
      default_ttl            = 86400
      max_ttl                = 31536000
    },
  ]

  viewer_certificate = [
    {
      acm_certificate_arn = lookup(
        var.cloudfront_app,
        "${terraform.workspace}.certificate_arn",
        var.cloudfront_app["default.certificate_arn"],
      )
      ssl_support_method = lookup(
        var.cloudfront_app,
        "${terraform.workspace}.ssl_support_method",
        var.cloudfront_app["default.ssl_support_method"],
      )
      minimum_protocol_version = "TLSv1"
    },
  ]

  tags = {
    "Environment" = terraform.workspace
    "Terraform"   = "true"
  }
}
