terraform {
  required_version = ">= 1.9"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

provider "aws" {
    region = "us-west-2"
    default_tags {
        tags = {
            owner = "bruno"
            managed-by = "terraform"
        }      
    }
}