variable "environment" {
  description = "환경 이름"
  type        = string
}

variable "instance_name" {
  description = "EC2 인스턴스 이름"
  type        = string
}

variable "instance_type" {
  description = "EC2 인스턴스 타입"
  type        = string
}

variable "ami_id" {
  description = "EC2 인스턴스용 AMI ID"
  type        = string
}

variable "subnet_id" {
  description = "인스턴스가 실행될 서브넷 ID"
  type        = string
}

variable "security_group_ids" {
  description = "보안 그룹 ID 목록"
  type        = list(string)
  default     = []
}

variable "iam_instance_profile" {
  description = "IAM 인스턴스 프로파일 이름"
  type        = string
  default     = ""
}

variable "ebs_volume_size" {
  description = "EBS 볼륨 크기 (GB)"
  type        = number
  default     = 20
}

variable "ebs_volume_type" {
  description = "EBS 볼륨 타입"
  type        = string
  default     = "gp3"
}

variable "ebs_encrypted" {
  description = "EBS 암호화 활성화 여부"
  type        = bool
  default     = true
}

variable "credit_specification" {
  description = "T 시리즈 인스턴스 크레딧 사양 (unlimited 또는 standard)"
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["unlimited", "standard"], var.credit_specification)
    error_message = "크레딧 사양은 'unlimited' 또는 'standard' 중 하나여야 합니다."
  }
}

variable "enable_credit_specification" {
  description = "크레딧 사양 활성화 여부 (T 시리즈 인스턴스만 해당)"
  type        = bool
  default     = false
}

variable "team_tag" {
  description = "인스턴스의 팀 태그"
  type        = string
}

variable "additional_tags" {
  description = "인스턴스에 추가할 태그"
  type        = map(string)
  default     = {}
}
