output "vpc_id" {
  description = "개발 환경 VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "개발 환경 VPC CIDR 블록"
  value       = module.vpc.vpc_cidr_block
}

output "internet_gateway_id" {
  description = "개발 환경 인터넷 게이트웨이 ID"
  value       = module.vpc.internet_gateway_id
}

output "public_subnet_id" {
  description = "개발 환경 퍼블릭 서브넷 ID"
  value       = module.subnet.public_subnet_id
}

output "public_subnet_cidr" {
  description = "개발 환경 퍼블릭 서브넷 CIDR"
  value       = module.subnet.public_subnet_cidr
}

output "private_subnet_id" {
  description = "개발 환경 프라이빗 서브넷 ID"
  value       = module.subnet.private_subnet_id
}

output "private_subnet_cidr" {
  description = "개발 환경 프라이빗 서브넷 CIDR"
  value       = module.subnet.private_subnet_cidr
}

output "public_route_table_id" {
  description = "개발 환경 퍼블릭 라우트 테이블 ID"
  value       = module.subnet.public_route_table_id
}

output "private_route_table_id" {
  description = "개발 환경 프라이빗 라우트 테이블 ID"
  value       = module.subnet.private_route_table_id
}
