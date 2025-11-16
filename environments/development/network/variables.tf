variable "aws_region" {
  description = "리소스를 위한 AWS 리전"
  type        = string
  default     = "ap-northeast-2"
}

variable "environment" {
  description = "환경 이름"
  type        = string
  default     = "development"
}

variable "vpc_cidr" {
  description = "VPC CIDR 블록"
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  description = "퍼블릭 서브넷 CIDR 블록"
  type        = string
  default     = "10.20.0.0/24"
}

variable "private_subnet_cidr" {
  description = "프라이빗 서브넷 CIDR 블록"
  type        = string
  default     = "10.20.1.0/24"
}

variable "availability_zone" {
  description = "서브넷의 가용 영역"
  type        = string
  default     = "ap-northeast-2a"
}

variable "common_tags" {
  description = "모든 리소스의 공통 태그"
  type        = map(string)
  default = {
    Environment = "development"
    ManagedBy   = "Terraform"
  }
}
