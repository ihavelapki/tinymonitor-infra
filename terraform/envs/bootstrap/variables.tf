variable "aws_region" {
  description = "AWS region for bootstrap resources"
  type        = string
  default     = "eu-central-1"
}

variable "aws_profile" {
  type    = string
  default = "tinymonitor-bootstrap"
}

variable "project_name" {
  description = "Project name used in resource names"
  type        = string
  default     = "tinymonitor"
}

variable "tfstate_bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
}

variable "tf_lock_table_name" {
  description = "DynamoDB table name for Terraform state locks"
  type        = string
  default     = "tinymonitor-terraform-locks"
}