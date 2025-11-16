output "c_type_instance_id" {
  description = "C 타입 EC2 인스턴스의 ID"
  value       = module.ec2_c_type.instance_id
}

output "c_type_instance_public_ip" {
  description = "C 타입 EC2 인스턴스의 퍼블릭 IP"
  value       = module.ec2_c_type.instance_public_ip
}

output "c_type_instance_private_ip" {
  description = "C 타입 EC2 인스턴스의 프라이빗 IP"
  value       = module.ec2_c_type.instance_private_ip
}

output "m_type_instance_id" {
  description = "M 타입 EC2 인스턴스의 ID"
  value       = module.ec2_m_type.instance_id
}

output "m_type_instance_public_ip" {
  description = "M 타입 EC2 인스턴스의 퍼블릭 IP"
  value       = module.ec2_m_type.instance_public_ip
}

output "m_type_instance_private_ip" {
  description = "M 타입 EC2 인스턴스의 프라이빗 IP"
  value       = module.ec2_m_type.instance_private_ip
}

output "t_type_instance_id" {
  description = "T 타입 EC2 인스턴스의 ID"
  value       = module.ec2_t_type.instance_id
}

output "t_type_instance_public_ip" {
  description = "T 타입 EC2 인스턴스의 퍼블릭 IP"
  value       = module.ec2_t_type.instance_public_ip
}

output "t_type_instance_private_ip" {
  description = "T 타입 EC2 인스턴스의 프라이빗 IP"
  value       = module.ec2_t_type.instance_private_ip
}

output "c_type_security_group_ids" {
  description = "C 타입 인스턴스의 보안 그룹 ID"
  value       = [var.security_group_id]
}

output "c_type_iam_instance_profile" {
  description = "C 타입 인스턴스의 IAM 인스턴스 프로파일"
  value       = var.iam_instance_profile
}

output "m_type_security_group_ids" {
  description = "M 타입 인스턴스의 보안 그룹 ID"
  value       = [var.security_group_id]
}

output "m_type_iam_instance_profile" {
  description = "M 타입 인스턴스의 IAM 인스턴스 프로파일"
  value       = var.iam_instance_profile
}

output "t_type_security_group_ids" {
  description = "T 타입 인스턴스의 보안 그룹 ID"
  value       = [var.security_group_id]
}

output "t_type_iam_instance_profile" {
  description = "T 타입 인스턴스의 IAM 인스턴스 프로파일"
  value       = var.iam_instance_profile
}
