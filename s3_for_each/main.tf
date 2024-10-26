terraform {
  required_version = ">= 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.70.0"
    }
  }
    backend "s3" {
    bucket = "remote-state-btenorio"
    key    = "remote-state-s3-for_each.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      owner      = "bruno"
      managed-by = "terraform"
    }
  }
}