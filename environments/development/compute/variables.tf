# Compute Environment Variables

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "ap-northeast-2"
}

variable "environment" {
  description = "Environment name (development/staging/production)"
  type        = string
  default     = "development"
}

# Network State Configuration
variable "network_state_bucket" {
  description = "S3 bucket name for network state storage"
  type        = string
  default     = "terraform-state-20251109"
}

variable "network_state_key" {
  description = "S3 key for network state file"
  type        = string
  default     = "development/network/terraform.tfstate"
}

# Security Configuration
variable "security_group_id" {
  description = "Security group ID for EC2 instances"
  type        = string
  default     = "sg-02c5fbd7d50f084d1"
}

variable "iam_instance_profile" {
  description = "IAM instance profile name for EC2 instances"
  type        = string
  default     = "development-ec2-profile"
}

# EBS Configuration
variable "ebs_volume_size" {
  description = "Size of the EBS volume in GB"
  type        = number
  default     = 30
}

variable "ebs_volume_type" {
  description = "Type of the EBS volume"
  type        = string
  default     = "gp3"
}

variable "ebs_encrypted" {
  description = "Whether to encrypt the EBS volume"
  type        = bool
  default     = true
}

# Instance Configuration - C Type
variable "c_type_instance_type" {
  description = "Instance type for compute-optimized workloads"
  type        = string
  default     = "c5.large"
}

variable "c_type_team_tag" {
  description = "Team tag for C-type instance"
  type        = string
  default     = "compute-team"
}

# Instance Configuration - M Type
variable "m_type_instance_type" {
  description = "Instance type for general-purpose workloads"
  type        = string
  default     = "m5.large"
}

variable "m_type_team_tag" {
  description = "Team tag for M-type instance"
  type        = string
  default     = "platform-team"
}

# Instance Configuration - T Type
variable "t_type_instance_type" {
  description = "Instance type for burstable workloads"
  type        = string
  default     = "t3.medium"
}

variable "t_type_team_tag" {
  description = "Team tag for T-type instance"
  type        = string
  default     = "web-team"
}

variable "t_type_credit_specification" {
  description = "Credit specification for T-type instance (standard/unlimited)"
  type        = string
  default     = "standard"
}

# Common Tags
variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "development"
    ManagedBy   = "Terraform"
    Project     = "Infrastructure"
  }
}