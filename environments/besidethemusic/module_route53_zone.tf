variable "route53_zone_app" {
  type = map(string)

  default = {
    "default.name" = "besidethemusic.tokyo"
  }
}

module "route53_zone_app" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//route53_zone"
  name = lookup(
    var.route53_zone_app,
    "${terraform.workspace}.name",
    var.route53_zone_app["default.name"],
  )
}
