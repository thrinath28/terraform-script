terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.61.0"
    }
  }
  
  backend "s3" {
    bucket = "my-terrform-state"
    key    = "state"
    region = "ap-south-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.REGION
}