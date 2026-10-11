output "tfstate_bucket_name" {
  description = "S3 bucket for remote Terraform states"
  value       = aws_s3_bucket.tfstate.bucket
}

output "terraform_plan_role_arn" {
  description = "IAM role used by GitHub Actions for Terraform plan"
  value       = aws_iam_role.terraform_plan.arn
}

output "terraform_apply_role_arn" {
  description = "IAM role used by GitHub Actions for Terraform apply"
  value       = aws_iam_role.terraform_apply.arn
}