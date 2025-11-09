# Terraform Infrastructure

이 프로젝트는 AWS 인프라를 모듈화된 Terraform 코드로 관리합니다.

## 디렉토리 구조

```
terraform/
├── modules/                    # 재사용 가능한 Terraform 모듈
│   ├── vpc/                   # VPC 모듈
│   └── subnet/                # Subnet 모듈
├── environments/              # 환경별 설정
│   ├── production/           # 운영 환경
│   │   └── network/          # 네트워크 리소스 (별도 state)
│   ├── staging/              # 스테이지 환경
│   │   └── network/          # 네트워크 리소스 (별도 state)
│   └── development/          # 개발 환경
│       └── network/          # 네트워크 리소스 (별도 state)
└── README.md
```

## 환경별 네트워크 구성

### Production (운영 환경)
- VPC CIDR: `10.0.0.0/16`
- Public Subnet: `10.0.0.0/24`
- Private Subnet: `10.0.1.0/24`

### Staging (스테이지 환경)
- VPC CIDR: `10.10.0.0/16`
- Public Subnet: `10.10.0.0/24`
- Private Subnet: `10.10.1.0/24`

### Development (개발 환경)
- VPC CIDR: `10.20.0.0/16`
- Public Subnet: `10.20.0.0/24`
- Private Subnet: `10.20.1.0/24`

## 사용 방법

### 1. 초기 설정

각 환경 디렉토리로 이동하여 Terraform을 초기화합니다:

```bash
# Production 환경 예시
cd environments/production/network
terraform init
```

### 2. Backend 설정 (State 파일 분리)

각 환경의 `main.tf`에서 backend 설정을 주석 해제하고 설정합니다.

#### S3 Backend 예시:

```hcl
backend "s3" {
  bucket         = "terraform-state-20251109"
  key            = "production/network/terraform.tfstate"
  region         = "ap-northeast-2"
  dynamodb_table = "terraform-state-lock"
  encrypt        = true
}
```

Backend 설정 후 재초기화:

```bash
terraform init -reconfigure
```

### 3. Plan 및 Apply

변경 사항을 미리 확인:

```bash
terraform plan
```

인프라 적용:

```bash
terraform apply
```

### 4. 리소스 확인

생성된 리소스 정보 확인:

```bash
terraform output
```

## State 파일 관리

네트워크 리소스는 변경 빈도가 낮기 때문에 별도의 state 파일로 분리되어 있습니다.

- **Production**: `production/network/terraform.tfstate`
- **Staging**: `staging/network/terraform.tfstate`
- **Development**: `development/network/terraform.tfstate`

이를 통해:
- 환경 간 독립적인 리소스 관리
- 네트워크 변경 시 다른 리소스에 영향 최소화
- State lock을 통한 동시 작업 방지

## 모듈 설명

### VPC 모듈 (`modules/vpc/`)
- VPC 생성
- Internet Gateway 생성
- DNS 지원 설정

### Subnet 모듈 (`modules/subnet/`)
- Public/Private Subnet 생성
- Route Table 생성 및 연결
- Public Subnet에 Internet Gateway 라우팅 설정

## 추가 리소스 추가 시

새로운 리소스 타입(예: RDS, EKS 등)을 추가할 때:

1. `modules/` 디렉토리에 새 모듈 생성
2. 각 환경의 적절한 디렉토리에 설정 추가
3. 별도의 state 파일이 필요한 경우 새 디렉토리 생성

예시:
```
environments/production/
├── network/      # 네트워크 리소스
├── database/     # 데이터베이스 리소스
└── compute/      # 컴퓨팅 리소스
```

## 주의사항

- **State 파일 백업**: S3 backend 사용 시 버전 관리 활성화 권장
- **DynamoDB 테이블**: State lock을 위해 DynamoDB 테이블 생성 필요
- **권한 관리**: 각 환경별로 적절한 IAM 권한 설정
- **태그 관리**: 비용 추적 및 관리를 위해 일관된 태그 전략 사용
