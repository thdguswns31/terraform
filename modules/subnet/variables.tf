variable "environment" {
  description = "Environment name (production, staging, development)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where subnets will be created"
  type        = string
}

variable "internet_gateway_id" {
  description = "Internet Gateway ID for public subnet routing"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the subnets"
  type        = string
}

variable "tags" {
  description = "Additional tags for subnet resources"
  type        = map(string)
  default     = {}
}
