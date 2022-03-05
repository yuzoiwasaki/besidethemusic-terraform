module "iam_circleci" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//iam_user?ref=v1.0.11"
  name   = "circleci"
}
