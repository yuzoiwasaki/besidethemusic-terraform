data "aws_iam_policy_document" "deployment_group" {
  statement {
    effect = "Allow"

    actions = [
      "cloudfront:CreateInvalidation",
      "s3:ListBucket",
      "s3:GetObject*",
      "s3:PutObject*",
    ]

    resources = ["*"]
  }
}

module "iam_deployment_group" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//iam_group?ref=v1.1.7"
  name   = "deployment"
  policy = data.aws_iam_policy_document.deployment_group.json

  membership_users = [
    module.iam_circleci.name,
  ]
}
