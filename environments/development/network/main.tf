terraform {
  required_version = ">= 1.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "tfstate-s3"
    key            = "development/network/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../../modules/vpc"

  environment          = var.environment
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.common_tags
}

module "subnet" {
  source = "../../../modules/subnet"

  environment          = var.environment
  vpc_id               = module.vpc.vpc_id
  internet_gateway_id  = module.vpc.internet_gateway_id
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidr  = var.private_subnet_cidr
  availability_zone    = var.availability_zone

  tags = var.common_tags
}
