# Terraform 상태 파일 저장용 S3 버킷
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-20251109" # 고유한 버킷 이름

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "management"
    ManagedBy   = "Terraform"
  }
}

# 상태 파일 이력 관리를 위한 버전 관리 활성화
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# 저장 시 암호화 활성화
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 퍼블릭 액세스 차단
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 상태 잠금을 위한 DynamoDB 테이블
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Lock Table"
    Environment = "management"
    ManagedBy   = "Terraform"
  }
}

# 출력 값
output "s3_bucket_name" {
  description = "Terraform 상태 파일 저장용 S3 버킷 이름"
  value       = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  description = "상태 잠금용 DynamoDB 테이블 이름"
  value       = aws_dynamodb_table.terraform_state_lock.id
}

output "s3_bucket_arn" {
  description = "S3 버킷의 ARN"
  value       = aws_s3_bucket.terraform_state.arn
}
