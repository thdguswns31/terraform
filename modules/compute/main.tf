resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile   = var.iam_instance_profile != "" ? var.iam_instance_profile : null

  root_block_device {
    volume_size           = var.ebs_volume_size
    volume_type           = var.ebs_volume_type
    encrypted             = var.ebs_encrypted
    delete_on_termination = true
  }

  # T 시리즈 인스턴스 크레딧 사양
  dynamic "credit_specification" {
    for_each = var.enable_credit_specification ? [1] : []
    content {
      cpu_credits = var.credit_specification
    }
  }

  tags = merge(
    {
      Name        = var.instance_name
      Environment = var.environment
      Team        = var.team_tag
      ManagedBy   = "Terraform"
    },
    var.additional_tags
  )

  volume_tags = merge(
    {
      Name        = "${var.instance_name}-root-volume"
      Environment = var.environment
      Team        = var.team_tag
      ManagedBy   = "Terraform"
    },
    var.additional_tags
  )
}
