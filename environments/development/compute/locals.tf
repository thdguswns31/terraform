locals {
  # Environment and Region
  environment = "development"
  region      = "ap-northeast-2"

  # Naming Convention
  name_prefix = local.environment

  # Network State Configuration
  network_state_config = {
    bucket = "terraform-state-20251109"
    key    = "development/network/terraform.tfstate"
    region = "ap-northeast-2"
  }

  # EC2 Instance Types
  instance_types = {
    c_type = "c5.large"
    m_type = "m5.large"
    t_type = "t3.medium"
  }

  # EC2 Instance Names
  instance_names = {
    c_type = "${local.name_prefix}-c-type-instance"
    m_type = "${local.name_prefix}-m-type-instance"
    t_type = "${local.name_prefix}-t-type-instance"
  }

  # Team Tags
  team_tags = {
    c_type = "compute-team"
    m_type = "platform-team"
    t_type = "web-team"
  }

  # EBS Configuration
  ebs_config = {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
  }

  # T Series Credit Specification
  t_series_credit = "standard" # or "unlimited"

  # Security Group Configuration
  security_group = {
    name        = "${local.name_prefix}-ec2-sg"
    description = "Security group for EC2 instances"
  }

  # Security Group Rules
  ingress_rules = [
    {
      description = "SSH from anywhere"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTP from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTPS from anywhere"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  # IAM Configuration
  iam_config = {
    role_name             = "${local.name_prefix}-ec2-role"
    instance_profile_name = "${local.name_prefix}-ec2-profile"
  }

  # SSM Policy ARN
  ssm_policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

  # Common Tags
  common_tags = {
    Environment = local.environment
    ManagedBy   = "Terraform"
    Project     = "Infrastructure"
  }
}
