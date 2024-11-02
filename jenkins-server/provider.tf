terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
}
data "aws_availability_zones" "azs" {}

provider "aws" {
  region = "us-east-1"
  # Configuration options
}
