output "vpc_id" {
  description = "Development VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "Development VPC CIDR block"
  value       = module.vpc.vpc_cidr_block
}

output "internet_gateway_id" {
  description = "Development Internet Gateway ID"
  value       = module.vpc.internet_gateway_id
}

output "public_subnet_id" {
  description = "Development public subnet ID"
  value       = module.subnet.public_subnet_id
}

output "public_subnet_cidr" {
  description = "Development public subnet CIDR"
  value       = module.subnet.public_subnet_cidr
}

output "private_subnet_id" {
  description = "Development private subnet ID"
  value       = module.subnet.private_subnet_id
}

output "private_subnet_cidr" {
  description = "Development private subnet CIDR"
  value       = module.subnet.private_subnet_cidr
}

output "public_route_table_id" {
  description = "Development public route table ID"
  value       = module.subnet.public_route_table_id
}

output "private_route_table_id" {
  description = "Development private route table ID"
  value       = module.subnet.private_route_table_id
}
