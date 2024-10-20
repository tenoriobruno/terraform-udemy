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
    key    = "remote-state-ec2-local-module.tfstate"
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

module "ec2" {
  source      = "./vpc-module"
  cidr_vpc    = "10.0.0.0/16"
  cidr_subnet = var.cidr_subnet
  env         = var.env
}