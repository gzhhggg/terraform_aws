# terraformの設定
terraform {
  required_version = "~> 1.3.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.49.0"
    }
  }
  backend "s3" {
    bucket = "adachi-terraform-aws-tfstate"
    region = "ap-northeast-1"
    key = "terraform.tfstate"
  }
}


# プロバイダーの設定
provider "aws" {
  region = "ap-northeast-1"
  access_key = var.access_key
  secret_key = var.secret_key
  default_tags {
    tags = {
      Project = "test-project"
      Service = "test"
      Env = "test"
      Provisioning = "terraform"
    }
  }
}