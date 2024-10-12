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
    key    = "remote-state-ec2.tfstate"
    region = "us-west-2"
  }
}

provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      owner      = "bruno"
      managed-by = "terraform"
    }
  }
}

data "terraform_remote_state" "remote_data_source_vpc" {
  backend = "s3"
  config = {
    bucket = "remote-state-btenorio"
    key    = "remote-state-vpc.tfstate"
    region = "us-west-2"
  }
}