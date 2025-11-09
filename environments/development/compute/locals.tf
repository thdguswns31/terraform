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

  default_ebs_config = {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = true
  }

  common_tags = {
    Environment = local.environment
    ManagedBy   = "Terraform"
    Project     = "Infrastructure"
  }

  c_type = {
    instance_name               = "${local.name_prefix}-c-type-instance"
    instance_type               = "c5.large"
    team_tag                    = "compute-team"
    enable_credit_specification = false
    credit_specification        = null
    security_group_ids = [
      "sg-02c5fbd7d50f084d1",
    ]
    iam_instance_profile_name = "development-ec2-profile"
    ebs_config = local.default_ebs_config
  }

  m_type = {
    instance_name               = "${local.name_prefix}-m-type-instance"
    instance_type               = "m5.large"
    team_tag                    = "platform-team"
    enable_credit_specification = false
    credit_specification        = null
    security_group_ids = [
      "sg-02c5fbd7d50f084d1",
    ]
    iam_instance_profile_name = "development-ec2-profile"
    ebs_config = local.default_ebs_config
  }

  t_type = {
    instance_name               = "${local.name_prefix}-t-type-instance"
    instance_type               = "t3.medium"
    team_tag                    = "web-team"
    enable_credit_specification = true
    credit_specification        = "standard"
    security_group_ids = [
      "sg-02c5fbd7d50f084d1",
    ]
    iam_instance_profile_name = "development-ec2-profile"
    ebs_config = local.default_ebs_config
  }
}
