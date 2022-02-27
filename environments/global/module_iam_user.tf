module "iam_circleci" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//iam_user?ref=v0.15.5"
  name   = "circleci"
}
