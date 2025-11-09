variable "environment" {
  description = "Environment name"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
  default     = ""
}

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

variable "credit_specification" {
  description = "Credit specification for T series instances (unlimited or standard)"
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["unlimited", "standard"], var.credit_specification)
    error_message = "Credit specification must be either 'unlimited' or 'standard'."
  }
}

variable "enable_credit_specification" {
  description = "Whether to enable credit specification (only for T series instances)"
  type        = bool
  default     = false
}

variable "team_tag" {
  description = "Team tag for the instance"
  type        = string
}

variable "additional_tags" {
  description = "Additional tags for the instance"
  type        = map(string)
  default     = {}
}
