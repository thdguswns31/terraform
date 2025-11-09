output "vpc_id" {
  description = "Production VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "Production VPC CIDR block"
  value       = module.vpc.vpc_cidr_block
}

output "internet_gateway_id" {
  description = "Production Internet Gateway ID"
  value       = module.vpc.internet_gateway_id
}

output "public_subnet_id" {
  description = "Production public subnet ID"
  value       = module.subnet.public_subnet_id
}

output "public_subnet_cidr" {
  description = "Production public subnet CIDR"
  value       = module.subnet.public_subnet_cidr
}

output "private_subnet_id" {
  description = "Production private subnet ID"
  value       = module.subnet.private_subnet_id
}

output "private_subnet_cidr" {
  description = "Production private subnet CIDR"
  value       = module.subnet.private_subnet_cidr
}

output "public_route_table_id" {
  description = "Production public route table ID"
  value       = module.subnet.public_route_table_id
}

output "private_route_table_id" {
  description = "Production private route table ID"
  value       = module.subnet.private_route_table_id
}
