terraform {
  required_version = ">= 1.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-20251109"
    key            = "development/compute/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

# 네트워크 상태를 가져오기 위한 데이터 소스
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = var.network_state_bucket
    key    = var.network_state_key
    region = var.aws_region
  }
}

# 최신 Amazon Linux 2023 AMI를 가져오기 위한 데이터 소스
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# C 타입 인스턴스 (컴퓨팅 최적화)
module "ec2_c_type" {
  source = "../../../modules/compute"

  environment                 = var.environment
  instance_name               = "${var.environment}-c-type-instance"
  instance_type               = var.c_type_instance_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id
  security_group_ids          = [var.security_group_id]
  iam_instance_profile        = var.iam_instance_profile
  ebs_volume_size             = var.ebs_volume_size
  ebs_volume_type             = var.ebs_volume_type
  ebs_encrypted               = var.ebs_encrypted
  enable_credit_specification = false
  team_tag                    = var.c_type_team_tag
  additional_tags             = var.common_tags
}

# M 타입 인스턴스 (범용)
module "ec2_m_type" {
  source = "../../../modules/compute"

  environment                 = var.environment
  instance_name               = "${var.environment}-m-type-instance"
  instance_type               = var.m_type_instance_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id
  security_group_ids          = [var.security_group_id]
  iam_instance_profile        = var.iam_instance_profile
  ebs_volume_size             = var.ebs_volume_size
  ebs_volume_type             = var.ebs_volume_type
  ebs_encrypted               = var.ebs_encrypted
  enable_credit_specification = false
  team_tag                    = var.m_type_team_tag
  additional_tags             = var.common_tags
}

# T 타입 인스턴스 (버스트 가능 성능)
module "ec2_t_type" {
  source = "../../../modules/compute"

  environment                 = var.environment
  instance_name               = "${var.environment}-t-type-instance"
  instance_type               = var.t_type_instance_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id
  security_group_ids          = [var.security_group_id]
  iam_instance_profile        = var.iam_instance_profile
  ebs_volume_size             = var.ebs_volume_size
  ebs_volume_type             = var.ebs_volume_type
  ebs_encrypted               = var.ebs_encrypted
  enable_credit_specification = true
  credit_specification        = var.t_type_credit_specification
  team_tag                    = var.t_type_team_tag
  additional_tags             = var.common_tags
}
