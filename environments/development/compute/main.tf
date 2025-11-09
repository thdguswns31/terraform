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
  region = local.region
}

# Data source to get network state
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = local.network_state_config.bucket
    key    = local.network_state_config.key
    region = local.network_state_config.region
  }
}

# Data source to get latest Amazon Linux 2023 AMI
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

# C Type Instance (Compute Optimized)
module "ec2_c_type" {
  source = "../../../modules/compute"

  environment                 = local.environment
  instance_name               = local.c_type.instance_name
  instance_type               = local.c_type.instance_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id
  security_group_ids          = local.c_type.security_group_ids
  iam_instance_profile        = local.c_type.iam_instance_profile_name
  ebs_volume_size             = local.c_type.ebs_config.volume_size
  ebs_volume_type             = local.c_type.ebs_config.volume_type
  ebs_encrypted               = local.c_type.ebs_config.encrypted
  enable_credit_specification = local.c_type.enable_credit_specification
  team_tag                    = local.c_type.team_tag
  additional_tags             = local.common_tags
}

# M Type Instance (General Purpose)
module "ec2_m_type" {
  source = "../../../modules/compute"

  environment                 = local.environment
  instance_name               = local.m_type.instance_name
  instance_type               = local.m_type.instance_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id
  security_group_ids          = local.m_type.security_group_ids
  iam_instance_profile        = local.m_type.iam_instance_profile_name
  ebs_volume_size             = local.m_type.ebs_config.volume_size
  ebs_volume_type             = local.m_type.ebs_config.volume_type
  ebs_encrypted               = local.m_type.ebs_config.encrypted
  enable_credit_specification = local.m_type.enable_credit_specification
  team_tag                    = local.m_type.team_tag
  additional_tags             = local.common_tags
}

# T Type Instance (Burstable Performance)
module "ec2_t_type" {
  source = "../../../modules/compute"

  environment                 = local.environment
  instance_name               = local.t_type.instance_name
  instance_type               = local.t_type.instance_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id
  security_group_ids          = local.t_type.security_group_ids
  iam_instance_profile        = local.t_type.iam_instance_profile_name
  ebs_volume_size             = local.t_type.ebs_config.volume_size
  ebs_volume_type             = local.t_type.ebs_config.volume_type
  ebs_encrypted               = local.t_type.ebs_config.encrypted
  enable_credit_specification = local.t_type.enable_credit_specification
  credit_specification        = local.t_type.credit_specification
  team_tag                    = local.t_type.team_tag
  additional_tags             = local.common_tags
}
