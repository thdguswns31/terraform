# 컴퓨트 환경 변수

variable "aws_region" {
  description = "배포를 위한 AWS 리전"
  type        = string
  default     = "ap-northeast-2"
}

variable "environment" {
  description = "환경 이름 (development/staging/production)"
  type        = string
  default     = "development"
}

# 네트워크 상태 구성
variable "network_state_bucket" {
  description = "네트워크 상태 저장용 S3 버킷 이름"
  type        = string
  default     = "terraform-state-20251109"
}

variable "network_state_key" {
  description = "네트워크 상태 파일의 S3 키"
  type        = string
  default     = "development/network/terraform.tfstate"
}

# 보안 구성
variable "security_group_id" {
  description = "EC2 인스턴스용 보안 그룹 ID"
  type        = string
  default     = "sg-0f7898374d2abd21c"
}

variable "iam_instance_profile" {
  description = "EC2 인스턴스용 IAM 인스턴스 프로파일 이름"
  type        = string
  default     = "development-ec2-profile"
}

# EBS 구성
variable "ebs_volume_size" {
  description = "EBS 볼륨 크기 (GB)"
  type        = number
  default     = 30
}

variable "ebs_volume_type" {
  description = "EBS 볼륨 타입"
  type        = string
  default     = "gp3"
}

variable "ebs_encrypted" {
  description = "EBS 볼륨 암호화 여부"
  type        = bool
  default     = true
}

# 인스턴스 구성 - C 타입
variable "c_type_instance_type" {
  description = "컴퓨팅 최적화 워크로드용 인스턴스 타입"
  type        = string
  default     = "c5.large"
}

variable "c_type_team_tag" {
  description = "C 타입 인스턴스의 팀 태그"
  type        = string
  default     = "compute-team"
}

# 인스턴스 구성 - M 타입
variable "m_type_instance_type" {
  description = "범용 워크로드용 인스턴스 타입"
  type        = string
  default     = "m5.large"
}

variable "m_type_team_tag" {
  description = "M 타입 인스턴스의 팀 태그"
  type        = string
  default     = "platform-team"
}

# 인스턴스 구성 - T 타입
variable "t_type_instance_type" {
  description = "버스트 가능 워크로드용 인스턴스 타입"
  type        = string
  default     = "t3.medium"
}

variable "t_type_team_tag" {
  description = "T 타입 인스턴스의 팀 태그"
  type        = string
  default     = "web-team"
}

variable "t_type_credit_specification" {
  description = "T 타입 인스턴스의 크레딧 사양 (standard/unlimited)"
  type        = string
  default     = "standard"
}

# 공통 태그
variable "common_tags" {
  description = "모든 리소스에 적용할 공통 태그"
  type        = map(string)
  default = {
    Environment = "development"
    ManagedBy   = "Terraform"
    Project     = "Infrastructure"
  }
}