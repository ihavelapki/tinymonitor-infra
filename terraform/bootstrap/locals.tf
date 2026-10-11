data "aws_caller_identity" "current" {}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id

  tfstate_bucket_name = "${var.project_name}-tfstate-${var.environment}-${local.aws_account_id}"

  tfstate_prefix = "projects/"
}