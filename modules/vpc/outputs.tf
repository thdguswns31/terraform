output "vpc_id" {
  description = "VPC의 ID"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "VPC의 CIDR 블록"
  value       = aws_vpc.main.cidr_block
}

output "internet_gateway_id" {
  description = "인터넷 게이트웨이의 ID"
  value       = aws_internet_gateway.main.id
}

output "vpc_arn" {
  description = "VPC의 ARN"
  value       = aws_vpc.main.arn
}
