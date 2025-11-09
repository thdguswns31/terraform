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

# Security Group
resource "aws_security_group" "ec2_sg" {
  name        = local.security_group.name
  description = local.security_group.description
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = local.egress_rules
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = local.security_group.name
    }
  )
}

# IAM Role
resource "aws_iam_role" "ec2_role" {
  name = local.iam_config.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    local.common_tags,
    {
      Name = local.iam_config.role_name
    }
  )
}

# IAM Policy attachment - SSM access for EC2
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = local.ssm_policy_arn
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = local.iam_config.instance_profile_name
  role = aws_iam_role.ec2_role.name

  tags = merge(
    local.common_tags,
    {
      Name = local.iam_config.instance_profile_name
    }
  )
}

# C Type Instance (Compute Optimized)
module "ec2_c_type" {
  source = "../../../modules/compute"

  environment                 = local.environment
  instance_name               = local.instance_names.c_type
  instance_type               = local.instance_types.c_type
  ami_id                      = data.aws_ami.amazon_linux_2023.id
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id
  security_group_ids          = [aws_security_group.ec2_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
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
  security_group_ids          = [aws_security_group.ec2_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
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
  security_group_ids          = [aws_security_group.ec2_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  ebs_volume_size             = local.ebs_config.volume_size
  ebs_volume_type             = local.ebs_config.volume_type
  ebs_encrypted               = local.ebs_config.encrypted
  enable_credit_specification = true
  credit_specification        = local.t_series_credit
  team_tag                    = local.team_tags.t_type
  additional_tags             = local.common_tags
}
