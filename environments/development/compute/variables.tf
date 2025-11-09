variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "ap-northeast-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}

# EC2 Instance Type Variables
variable "c_type_instance_type" {
  description = "Instance type for C series (Compute Optimized)"
  type        = string
  default     = "c5.large"
}

variable "m_type_instance_type" {
  description = "Instance type for M series (General Purpose)"
  type        = string
  default     = "m5.large"
}

variable "t_type_instance_type" {
  description = "Instance type for T series (Burstable Performance)"
  type        = string
  default     = "t3.medium"
}

# EBS Configuration
variable "ebs_volume_size" {
  description = "Size of the EBS volume in GB"
  type        = number
  default     = 20
}

variable "ebs_volume_type" {
  description = "Type of EBS volume"
  type        = string
  default     = "gp3"
}

variable "ebs_encrypted" {
  description = "Whether to enable EBS encryption"
  type        = bool
  default     = true
}

# T Series Credit Specification
variable "t_type_credit_specification" {
  description = "Credit specification for T series instances (unlimited or standard)"
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["unlimited", "standard"], var.t_type_credit_specification)
    error_message = "Credit specification must be either 'unlimited' or 'standard'."
  }
}

# Common Tags
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "development"
    ManagedBy   = "Terraform"
  }
}
