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

# Data source to reference existing Security Group
data "aws_security_group" "ec2_sg" {
  id = local.security_group_id
}

# Data source to reference existing IAM Instance Profile
data "aws_iam_instance_profile" "ec2_profile" {
  name = local.iam_instance_profile_name
}

# C Type Instance (Compute Optimized)
module "ec2_c_type" {
  source = "../../../modules/compute"

  environment                 = local.environment
  instance_name               = local.instance_names.c_type
  instance_type               = local.instance_types.c_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id
  security_group_ids          = [data.aws_security_group.ec2_sg.id]
  iam_instance_profile        = data.aws_iam_instance_profile.ec2_profile.name
  ebs_volume_size             = local.ebs_config.volume_size
  ebs_volume_type             = local.ebs_config.volume_type
  ebs_encrypted               = local.ebs_config.encrypted
  enable_credit_specification = false
  team_tag                    = local.team_tags.c_type
  additional_tags             = local.common_tags
}

# M Type Instance (General Purpose)
module "ec2_m_type" {
  source = "../../../modules/compute"

  environment                 = local.environment
  instance_name               = local.instance_names.m_type
  instance_type               = local.instance_types.m_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id
  security_group_ids          = [data.aws_security_group.ec2_sg.id]
  iam_instance_profile        = data.aws_iam_instance_profile.ec2_profile.name
  ebs_volume_size             = local.ebs_config.volume_size
  ebs_volume_type             = local.ebs_config.volume_type
  ebs_encrypted               = local.ebs_config.encrypted
  enable_credit_specification = false
  team_tag                    = local.team_tags.m_type
  additional_tags             = local.common_tags
}

# T Type Instance (Burstable Performance)
module "ec2_t_type" {
  source = "../../../modules/compute"

  environment                 = local.environment
  instance_name               = local.instance_names.t_type
  instance_type               = local.instance_types.t_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id
  security_group_ids          = [data.aws_security_group.ec2_sg.id]
  iam_instance_profile        = data.aws_iam_instance_profile.ec2_profile.name
  ebs_volume_size             = local.ebs_config.volume_size
  ebs_volume_type             = local.ebs_config.volume_type
  ebs_encrypted               = local.ebs_config.encrypted
  enable_credit_specification = true
  credit_specification        = local.t_series_credit
  team_tag                    = local.team_tags.t_type
  additional_tags             = local.common_tags
}
