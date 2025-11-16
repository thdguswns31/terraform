output "public_subnet_id" {
  description = "퍼블릭 서브넷의 ID"
  value       = aws_subnet.public.id
}

output "public_subnet_cidr" {
  description = "퍼블릭 서브넷의 CIDR 블록"
  value       = aws_subnet.public.cidr_block
}

output "private_subnet_id" {
  description = "프라이빗 서브넷의 ID"
  value       = aws_subnet.private.id
}

output "private_subnet_cidr" {
  description = "프라이빗 서브넷의 CIDR 블록"
  value       = aws_subnet.private.cidr_block
}

output "public_route_table_id" {
  description = "퍼블릭 라우트 테이블의 ID"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "프라이빗 라우트 테이블의 ID"
  value       = aws_route_table.private.id
}
