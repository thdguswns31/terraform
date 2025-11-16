variable "environment" {
  description = "환경 이름 (production, staging, development)"
  type        = string
}

variable "vpc_id" {
  description = "서브넷이 생성될 VPC ID"
  type        = string
}

variable "internet_gateway_id" {
  description = "퍼블릭 서브넷 라우팅용 인터넷 게이트웨이 ID"
  type        = string
}

variable "public_subnet_cidr" {
  description = "퍼블릭 서브넷용 CIDR 블록"
  type        = string
}

variable "private_subnet_cidr" {
  description = "프라이빗 서브넷용 CIDR 블록"
  type        = string
}

variable "availability_zone" {
  description = "서브넷의 가용 영역"
  type        = string
}

variable "tags" {
  description = "서브넷 리소스에 추가할 태그"
  type        = map(string)
  default     = {}
}
