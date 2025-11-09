output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

output "public_subnet_cidr" {
  description = "The CIDR block of the public subnet"
  value       = aws_subnet.public.cidr_block
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private.id
}

output "private_subnet_cidr" {
  description = "The CIDR block of the private subnet"
  value       = aws_subnet.private.cidr_block
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private.id
}
