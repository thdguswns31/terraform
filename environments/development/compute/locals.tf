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

  # ========================================
  # Existing AWS Resources (Manual Input Required)
  # ========================================
  # DevOps Engineer: Please update these IDs with your existing AWS resources

  # Security Group ID
  # Example: "sg-0123456789abcdef0"
  # To find your SG ID: AWS Console > EC2 > Security Groups or run `aws ec2 describe-security-groups`
  security_group_id = "sg-07aaa5f9d2487b57b"

  # IAM Instance Profile Name
  # Example: "my-ec2-instance-profile"
  # To find your profile: AWS Console > IAM > Roles > Instance Profiles or run `aws iam list-instance-profiles`
  iam_instance_profile_name = "development-ec2-profile"

  # Common Tags
  common_tags = {
    Environment = local.environment
    ManagedBy   = "Terraform"
    Project     = "Infrastructure"
  }
}
