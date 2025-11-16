variable "environment" {
  description = "환경 이름 (production, staging, development)"
  type        = string
}

variable "cidr_block" {
  description = "VPC용 CIDR 블록"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "VPC에서 DNS 호스트네임 활성화"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "VPC에서 DNS 지원 활성화"
  type        = bool
  default     = true
}

variable "tags" {
  description = "VPC 리소스에 추가할 태그"
  type        = map(string)
  default     = {}
}
