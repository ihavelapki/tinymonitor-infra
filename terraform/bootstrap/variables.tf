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

variable "environment" {
  type    = string
  default = "prod"
}

variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
}

variable "github_repository" {
  description = "GitHub repository containing Terraform infrastructure"
  type        = string
}