# AWS 구성
aws_region  = "ap-northeast-2"
environment = "development"

# VPC 구성
vpc_cidr = "10.20.0.0/16"

# Subnet 구성
public_subnet_cidr  = "10.20.0.0/24"
private_subnet_cidr = "10.20.1.0/24"
availability_zone   = "ap-northeast-2a"

# 태그
common_tags = {
  Environment = "development"
  ManagedBy   = "Terraform"
  Project     = "Infrastructure"
  Team        = "DevOps"
  CostCenter  = "Engineering"
}