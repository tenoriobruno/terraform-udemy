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

module "vpc-local" {
  source      = "./vpc-module"
  cidr_vpc    = "10.0.0.0/16"
  cidr_subnet = var.cidr_subnet
  env         = var.env
}

module "vpc-remote" {
  source      = "github.com/tenoriobruno/terraform-udemy//ec2-local-module/vpc-module"
  cidr_vpc    = "172.31.0.0/16"
  cidr_subnet = var.cidr_subnet_vpc_remote
  env         = var.env
}