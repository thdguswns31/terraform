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

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.ec2_sg.id
}

output "iam_role_arn" {
  description = "ARN of the EC2 IAM role"
  value       = aws_iam_role.ec2_role.arn
}

output "iam_instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = aws_iam_instance_profile.ec2_profile.name
}
