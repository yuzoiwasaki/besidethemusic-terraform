module "cloudfront_app" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//cloudfront?ref=v1.1.7"

  comment = "besidethemusic.tokyo"
  aliases = ["besidethemusic.tokyo"]

  default_root_object = "index.html"

  origins = [
    {
      domain_name = "besidethemusic-production.s3-website-ap-northeast-1.amazonaws.com"
      origin_id   = "besidethemusic-production"
      custom_origin_config = [
        {
          http_port              = 80
          https_port             = 443
          origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
          origin_protocol_policy = "http-only"
          origin_read_timeout    = 60
        },
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
      allowed_methods  = ["GET", "HEAD"]
      cached_methods   = ["GET", "HEAD"]
      target_origin_id = "besidethemusic-production"
      compress         = true
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
      acm_certificate_arn      = "arn:aws:acm:us-east-1:192619379047:certificate/e90bb546-4813-4cef-b838-c41380d3a3e3"
      ssl_support_method       = "sni-only"
      minimum_protocol_version = "TLSv1"
    },
  ]

  tags = {
    "Environment" = terraform.workspace
    "Terraform"   = "true"
  }
}
