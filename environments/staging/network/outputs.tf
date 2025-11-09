output "vpc_id" {
  description = "Staging VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "Staging VPC CIDR block"
  value       = module.vpc.vpc_cidr_block
}

output "internet_gateway_id" {
  description = "Staging Internet Gateway ID"
  value       = module.vpc.internet_gateway_id
}

output "public_subnet_id" {
  description = "Staging public subnet ID"
  value       = module.subnet.public_subnet_id
}

output "public_subnet_cidr" {
  description = "Staging public subnet CIDR"
  value       = module.subnet.public_subnet_cidr
}

output "private_subnet_id" {
  description = "Staging private subnet ID"
  value       = module.subnet.private_subnet_id
}

output "private_subnet_cidr" {
  description = "Staging private subnet CIDR"
  value       = module.subnet.private_subnet_cidr
}

output "public_route_table_id" {
  description = "Staging public route table ID"
  value       = module.subnet.public_route_table_id
}

output "private_route_table_id" {
  description = "Staging private route table ID"
  value       = module.subnet.private_route_table_id
}
