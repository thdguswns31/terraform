output "c_type_instance_id" {
  description = "ID of the C type EC2 instance"
  value       = module.ec2_c_type.instance_id
}

output "c_type_instance_public_ip" {
  description = "Public IP of the C type EC2 instance"
  value       = module.ec2_c_type.instance_public_ip
}

output "c_type_instance_private_ip" {
  description = "Private IP of the C type EC2 instance"
  value       = module.ec2_c_type.instance_private_ip
}

output "m_type_instance_id" {
  description = "ID of the M type EC2 instance"
  value       = module.ec2_m_type.instance_id
}

output "m_type_instance_public_ip" {
  description = "Public IP of the M type EC2 instance"
  value       = module.ec2_m_type.instance_public_ip
}

output "m_type_instance_private_ip" {
  description = "Private IP of the M type EC2 instance"
  value       = module.ec2_m_type.instance_private_ip
}

output "t_type_instance_id" {
  description = "ID of the T type EC2 instance"
  value       = module.ec2_t_type.instance_id
}

output "t_type_instance_public_ip" {
  description = "Public IP of the T type EC2 instance"
  value       = module.ec2_t_type.instance_public_ip
}

output "t_type_instance_private_ip" {
  description = "Private IP of the T type EC2 instance"
  value       = module.ec2_t_type.instance_private_ip
}

output "c_type_security_group_ids" {
  description = "Security Group IDs for C type instance"
  value       = [var.security_group_id]
}

output "c_type_iam_instance_profile" {
  description = "IAM instance profile for C type instance"
  value       = var.iam_instance_profile
}

output "m_type_security_group_ids" {
  description = "Security Group IDs for M type instance"
  value       = [var.security_group_id]
}

output "m_type_iam_instance_profile" {
  description = "IAM instance profile for M type instance"
  value       = var.iam_instance_profile
}

output "t_type_security_group_ids" {
  description = "Security Group IDs for T type instance"
  value       = [var.security_group_id]
}

output "t_type_iam_instance_profile" {
  description = "IAM instance profile for T type instance"
  value       = var.iam_instance_profile
}
