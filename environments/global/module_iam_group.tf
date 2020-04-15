#####################################
# For admin
# #####################################
## Set policy
data "aws_iam_policy_document" "admin_group" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

## Run module
module "iam_admin_group" {
  source = "git@github.com:yuzoiwasaki/aws-terraform-modules.git//iam_group"
  name   = "administrators"
  policy = data.aws_iam_policy_document.admin_group.json

  membership_users = [
    module.iam_iwasaki.name,
  ]
}
