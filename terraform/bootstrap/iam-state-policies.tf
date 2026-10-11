
data "aws_iam_policy_document" "terraform_plan_state" {
  statement {
    sid       = "ListStateBucket"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.tfstate.arn]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values = [
        local.tfstate_prefix,
        "${local.tfstate_prefix}*"
      ]
    }
  }

  statement {
    sid     = "ReadState"
    effect  = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      "${aws_s3_bucket.tfstate.arn}/${local.tfstate_prefix}*"
    ]
  }

  statement {
    sid    = "ManageStateLock"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "${aws_s3_bucket.tfstate.arn}/${local.tfstate_prefix}*.tflock"
    ]
  }
}

data "aws_iam_policy_document" "terraform_apply_state" {
  statement {
    sid       = "ListStateBucket"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.tfstate.arn]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values = [
        local.tfstate_prefix,
        "${local.tfstate_prefix}*"
      ]
    }
  }

  statement {
    sid    = "ReadWriteState"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.tfstate.arn}/${local.tfstate_prefix}*"
    ]
  }

  statement {
    sid    = "ManageStateLock"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "${aws_s3_bucket.tfstate.arn}/${local.tfstate_prefix}*.tflock"
    ]
  }
}

resource "aws_iam_role_policy" "terraform_plan_state" {
  name   = "terraform-state"
  role   = aws_iam_role.terraform_plan.id
  policy = data.aws_iam_policy_document.terraform_plan_state.json
}

resource "aws_iam_role_policy" "terraform_apply_state" {
  name   = "terraform-state"
  role   = aws_iam_role.terraform_apply.id
  policy = data.aws_iam_policy_document.terraform_apply_state.json
}
