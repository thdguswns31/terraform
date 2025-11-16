# AWS Configuration
aws_region  = "ap-northeast-2"
environment = "development"

# Network State Configuration (for remote state data source)
network_state_bucket = "terraform-state-20251109"
network_state_key    = "development/network/terraform.tfstate"

# Security Configuration
security_group_id    = "sg-0f7898374d2abd21c"
iam_instance_profile = "development-ec2-profile"

# EBS Configuration (applied to all instances)
ebs_volume_size = 30
ebs_volume_type = "gp3"
ebs_encrypted   = true

# C-Type Instance Configuration (Compute-Optimized)
c_type_instance_type = "c5.large"
c_type_team_tag      = "compute-team"

# M-Type Instance Configuration (General Purpose)
m_type_instance_type = "m5.large"
m_type_team_tag      = "platform-team"

# T-Type Instance Configuration (Burstable)
t_type_instance_type        = "t3.medium"
t_type_team_tag             = "web-team"
t_type_credit_specification = "standard" # Options: "standard" or "unlimited"

# Common Tags
common_tags = {
  Environment = "development"
  ManagedBy   = "Terraform"
  Project     = "Infrastructure"
  Team        = "DevOps"
  CostCenter  = "Engineering"
}