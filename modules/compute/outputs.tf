output "instance_id" {
  description = "EC2 인스턴스의 ID"
  value       = aws_instance.this.id
}

output "instance_arn" {
  description = "EC2 인스턴스의 ARN"
  value       = aws_instance.this.arn
}

output "instance_public_ip" {
  description = "EC2 인스턴스의 퍼블릭 IP"
  value       = aws_instance.this.public_ip
}

output "instance_private_ip" {
  description = "EC2 인스턴스의 프라이빗 IP"
  value       = aws_instance.this.private_ip
}

output "instance_state" {
  description = "EC2 인스턴스의 상태"
  value       = aws_instance.this.instance_state
}
