# Terraform Infrastructure 프로젝트

이 프로젝트는 AWS 인프라를 Terraform으로 관리하기 위한 프로젝트입니다. 모듈화된 구조로 설계되어 있으며, 환경별(Development, Staging, Production)로 인프라를 분리하여 관리할 수 있습니다.

## 목차

- [프로젝트 개요](#프로젝트-개요)
- [디렉토리 구조](#디렉토리-구조)
- [사전 요구사항](#사전-요구사항)
- [초기 설정](#초기-설정)
- [모듈 설명](#모듈-설명)
- [환경별 구성](#환경별-구성)
- [사용 방법](#사용-방법)
- [주요 명령어](#주요-명령어)
- [문제 해결](#문제-해결)

## 프로젝트 개요

이 프로젝트는 다음과 같은 특징을 가지고 있습니다:

- **모듈 기반 아키텍처**: 재사용 가능한 VPC, Subnet, Compute 모듈 제공
- **환경 분리**: Development, Staging, Production 환경별 독립적 관리
- **원격 상태 관리**: S3와 DynamoDB를 사용한 안전한 상태 파일 관리
- **협업 지원**: 상태 잠금(State Locking)으로 동시 수정 방지

## 디렉토리 구조

```
terraform/
├── backend-setup.tf              # Terraform 상태 관리 인프라 (S3, DynamoDB)
├── .terraform.lock.hcl          # Provider 버전 잠금 파일
├── .gitignore                   # Git 무시 파일 목록
├── modules/                     # 재사용 가능한 모듈
│   ├── vpc/                    # VPC 모듈
│   │   ├── main.tf            # VPC 및 Internet Gateway 리소스
│   │   ├── variables.tf       # 입력 변수 정의
│   │   └── outputs.tf         # 출력 값 정의
│   ├── subnet/                 # Subnet 모듈
│   │   ├── main.tf            # Public/Private Subnet 및 라우팅 테이블
│   │   ├── variables.tf       # 입력 변수 정의
│   │   └── outputs.tf         # 출력 값 정의
│   └── compute/                # EC2 인스턴스 모듈
│       ├── main.tf            # EC2 인스턴스 리소스
│       ├── variables.tf       # 입력 변수 정의
│       └── outputs.tf         # 출력 값 정의
└── environments/               # 환경별 설정
    └── development/            # 개발 환경
        ├── network/           # 네트워크 스택 (VPC, Subnet)
        │   ├── main.tf       # 네트워크 모듈 호출 및 구성
        │   ├── variables.tf  # 입력 변수 정의
        │   ├── outputs.tf    # 출력 값 (다른 스택에서 참조)
        │   ├── terraform.tfvars  # 실제 변수 값
        │   └── .terraform.lock.hcl
        └── compute/           # 컴퓨트 스택 (EC2)
            ├── main.tf       # EC2 모듈 호출 및 구성
            ├── variables.tf  # 입력 변수 정의
            ├── terraform.tfvars  # 실제 변수 값
            ├── outputs.tf    # 출력 값
            └── .terraform.lock.hcl
```

## 사전 요구사항

### 1. 필수 소프트웨어

- **Terraform**: 버전 1.13 이상
  ```bash
  # macOS
  brew install terraform

  # 버전 확인
  terraform version
  ```

- **AWS CLI**: AWS 계정 인증용
  ```bash
  # macOS
  brew install awscli

  # 버전 확인
  aws --version
  ```

### 2. AWS 계정 설정

AWS 자격 증명을 설정해야 합니다:

```bash
# AWS CLI 설정
aws configure

# 또는 환경 변수로 설정
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="ap-northeast-2"
```

### 3. 기존 AWS 리소스

현재 프로젝트는 다음 리소스가 미리 존재해야 합니다:

- **Security Group**: `sg-058b785b4a8b1af91`
- **IAM Instance Profile**: `development-ec2-profile`

## 초기 설정

프로젝트를 처음 사용할 때는 다음 순서대로 진행합니다.

### 1단계: 프로젝트 클론

```bash
git clone https://github.com/thdguswns31/terraform.git
cd terraform
```

### 2단계: 백엔드 인프라 생성 (최초 1회만 수행)

Terraform 상태 파일을 저장할 S3 버킷과 DynamoDB 테이블을 생성합니다.

```bash
# 프로젝트 루트에서 실행
terraform init
terraform plan
terraform apply

# 생성되는 리소스:
# - S3 버킷: terraform-state-20251109
# - DynamoDB 테이블: terraform-state-lock
```

이 작업으로 생성되는 리소스:
- **S3 버킷** (`terraform-state-20251109`):
  - Terraform 상태 파일 저장
  - 버전 관리 활성화
  - 서버 측 암호화 (AES256)
  - 퍼블릭 액세스 차단

- **DynamoDB 테이블** (`terraform-state-lock`):
  - 상태 파일 잠금 기능
  - 동시 수정 방지

### 3단계: 네트워크 인프라 배포

VPC와 서브넷을 생성합니다.

```bash
cd environments/development/network

# Terraform 초기화 (S3 백엔드 연결)
terraform init

# 실행 계획 확인
terraform plan

# 인프라 배포
terraform apply

# 배포 확인
terraform output
```

생성되는 리소스:
- VPC (CIDR: `10.20.0.0/16`)
- Internet Gateway
- Public Subnet (CIDR: `10.20.0.0/24`, AZ: `ap-northeast-2a`)
- Private Subnet (CIDR: `10.20.1.0/24`, AZ: `ap-northeast-2a`)
- Route Tables (Public/Private)

### 4단계: 컴퓨트 인프라 배포

EC2 인스턴스를 생성합니다.

```bash
cd ../compute

# Terraform 초기화
terraform init

# 실행 계획 확인
terraform plan

# 인프라 배포
terraform apply

# 배포 확인
terraform output
```

생성되는 리소스:
- C-Type 인스턴스 (c5.large) - Compute 최적화
- M-Type 인스턴스 (m5.large) - 범용
- T-Type 인스턴스 (t3.medium) - 버스트 가능

## 모듈 설명

### 1. VPC 모듈 (`modules/vpc`)

VPC와 Internet Gateway를 생성하는 모듈입니다.

**주요 기능**:
- VPC 생성 (사용자 지정 CIDR 블록)
- Internet Gateway 생성 및 연결
- DNS 호스트네임 및 DNS 지원 설정
- 태그 관리

**입력 변수**:
| 변수명 | 설명 | 기본값 |
|--------|------|--------|
| `environment` | 환경 이름 (dev, staging, prod) | 필수 |
| `cidr_block` | VPC CIDR 블록 | 필수 |
| `enable_dns_hostnames` | DNS 호스트네임 활성화 | `true` |
| `enable_dns_support` | DNS 지원 활성화 | `true` |
| `tags` | 추가 태그 | `{}` |

**출력 값**:
- `vpc_id`: VPC ID
- `vpc_cidr_block`: VPC CIDR 블록
- `internet_gateway_id`: Internet Gateway ID
- `vpc_arn`: VPC ARN

**사용 예시**:
```hcl
module "vpc" {
  source = "../../modules/vpc"

  environment          = "development"
  cidr_block          = "10.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Project = "MyProject"
  }
}
```

### 2. Subnet 모듈 (`modules/subnet`)

Public 및 Private 서브넷을 생성하고 라우팅을 설정하는 모듈입니다.

**주요 기능**:
- Public Subnet 생성 (퍼블릭 IP 자동 할당)
- Private Subnet 생성
- Route Table 생성 (Public/Private 각각)
- Internet Gateway로의 라우팅 설정
- Route Table Association

**입력 변수**:
| 변수명 | 설명 | 기본값 |
|--------|------|--------|
| `vpc_id` | VPC ID | 필수 |
| `internet_gateway_id` | Internet Gateway ID | 필수 |
| `environment` | 환경 이름 | 필수 |
| `public_subnet_cidr` | Public Subnet CIDR | 필수 |
| `private_subnet_cidr` | Private Subnet CIDR | 필수 |
| `availability_zone` | 가용 영역 | 필수 |
| `tags` | 추가 태그 | `{}` |

**출력 값**:
- `public_subnet_id`: Public Subnet ID
- `private_subnet_id`: Private Subnet ID
- `public_subnet_cidr`: Public Subnet CIDR
- `private_subnet_cidr`: Private Subnet CIDR
- `public_route_table_id`: Public Route Table ID
- `private_route_table_id`: Private Route Table ID

**사용 예시**:
```hcl
module "subnet" {
  source = "../../modules/subnet"

  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
  environment         = "development"
  public_subnet_cidr  = "10.20.0.0/24"
  private_subnet_cidr = "10.20.1.0/24"
  availability_zone   = "ap-northeast-2a"
}
```

### 3. Compute 모듈 (`modules/compute`)

EC2 인스턴스를 생성하는 모듈입니다.

**주요 기능**:
- EC2 인스턴스 생성 (유연한 설정)
- EBS 볼륨 설정 (크기, 타입, 암호화)
- T-시리즈 크레딧 사양 지원
- Security Group 연결
- IAM Instance Profile 연결
- 동적 태깅

**입력 변수**:
| 변수명 | 설명 | 기본값 |
|--------|------|--------|
| `instance_name` | 인스턴스 이름 | 필수 |
| `instance_type` | 인스턴스 타입 | 필수 |
| `ami_id` | AMI ID | 필수 |
| `subnet_id` | 서브넷 ID | 필수 |
| `security_group_ids` | Security Group ID 목록 | 필수 |
| `iam_instance_profile` | IAM Instance Profile 이름 | `null` |
| `ebs_volume_size` | EBS 볼륨 크기 (GB) | `20` |
| `ebs_volume_type` | EBS 볼륨 타입 | `"gp3"` |
| `ebs_encrypted` | EBS 암호화 여부 | `true` |
| `ebs_delete_on_termination` | 종료 시 EBS 삭제 여부 | `true` |
| `credit_specification` | T-시리즈 크레딧 사양 | `null` |
| `tags` | 추가 태그 | `{}` |

**출력 값**:
- `instance_id`: EC2 인스턴스 ID
- `instance_public_ip`: 퍼블릭 IP 주소
- `instance_private_ip`: 프라이빗 IP 주소
- `instance_arn`: 인스턴스 ARN

**사용 예시**:
```hcl
module "web_server" {
  source = "../../modules/compute"

  instance_name      = "web-server"
  instance_type      = "t3.medium"
  ami_id            = "ami-xxxxxxxxx"
  subnet_id         = module.subnet.public_subnet_id
  security_group_ids = ["sg-xxxxxxxxx"]
  iam_instance_profile = "my-instance-profile"

  ebs_volume_size = 30
  ebs_volume_type = "gp3"
  ebs_encrypted   = true

  credit_specification = "standard"

  tags = {
    Team = "DevOps"
  }
}
```

## 환경별 구성

### Development 환경

현재 설정된 개발 환경의 구성입니다.

#### 네트워크 설정 (`environments/development/network/terraform.tfvars`)

```hcl
aws_region          = "ap-northeast-2"      # 서울 리전
environment         = "development"
vpc_cidr            = "10.20.0.0/16"       # VPC CIDR 블록
public_subnet_cidr  = "10.20.0.0/24"       # Public Subnet
private_subnet_cidr = "10.20.1.0/24"       # Private Subnet
availability_zone   = "ap-northeast-2a"     # 가용 영역

common_tags = {
  Environment = "development"
  ManagedBy   = "Terraform"
  Project     = "Infrastructure"
}
```

#### 컴퓨트 설정 (`environments/development/compute/terraform.tfvars`)

현재 3가지 타입의 EC2 인스턴스가 배포됩니다:

| 인스턴스 이름 | 타입 | 용도 | 팀 | EBS | 크레딧 |
|--------------|------|------|-----|-----|--------|
| c-type-instance | c5.large | Compute 최적화 | compute-team | 30GB gp3 | - |
| m-type-instance | m5.large | 범용 | platform-team | 30GB gp3 | - |
| t-type-instance | t3.medium | 버스트 가능 | web-team | 30GB gp3 | standard |

**공통 설정**:
- AMI: Amazon Linux 2023 (최신 버전)
- Security Group: `sg-058b785b4a8b1af91`
- IAM Profile: `development-ec2-profile`
- Subnet: Public Subnet
- EBS 암호화: 활성화

### Staging/Production 환경 추가하기

새로운 환경을 추가하려면:

1. 환경 디렉토리 생성:
```bash
mkdir -p environments/staging/network
mkdir -p environments/staging/compute
```

2. Development 설정 파일 복사:
```bash
cp -r environments/development/network/* environments/staging/network/
cp -r environments/development/compute/* environments/staging/compute/
```

3. 환경별 값 수정:
- `terraform.tfvars`에서 환경별 변수 값 변경 (예: CIDR 블록 `10.30.0.0/16`)
- `main.tf`에서 백엔드 키 변경 (예: `staging/network/terraform.tfstate`)
- `variables.tf`에서 기본값 조정 (필요시)

## 사용 방법

### 일상적인 작업 흐름

#### 1. 변경 사항 계획 및 적용

```bash
# 원하는 환경 디렉토리로 이동
cd environments/development/network  # 또는 compute

# 변경 사항 확인
terraform plan

# 변경 사항을 파일로 저장 (선택사항, 권장)
terraform plan -out=tfplan

# 변경 사항 적용
terraform apply tfplan
# 또는
terraform apply
```

#### 2. 리소스 정보 확인

```bash
# 모든 출력 값 확인
terraform output

# 특정 출력 값 확인
terraform output vpc_id

# JSON 형식으로 출력
terraform output -json
```

#### 3. 상태 파일 관리

```bash
# 모든 리소스 목록 확인
terraform state list

# 특정 리소스 상세 정보 확인
terraform state show aws_vpc.main

# 상태 파일 새로고침 (AWS와 동기화)
terraform refresh
```

#### 4. 인프라 삭제

```bash
# 주의: 이 명령은 모든 리소스를 삭제합니다!
terraform destroy

# 특정 리소스만 삭제
terraform destroy -target=module.compute.aws_instance.this
```

### 코드 품질 관리

#### 코드 포맷팅

```bash
# 현재 디렉토리의 모든 .tf 파일 포맷팅
terraform fmt

# 재귀적으로 모든 하위 디렉토리 포맷팅
terraform fmt -recursive

# 포맷팅이 필요한 파일 확인 (수정하지 않음)
terraform fmt -check
```

#### 코드 검증

```bash
# 문법 검증
terraform validate

# 더 상세한 검증 (초기화 필요)
terraform init
terraform validate
```

### 협업 시나리오

#### 다른 사람이 변경한 내용 가져오기

```bash
# Git에서 최신 코드 가져오기
git pull

# 원격 상태 파일과 동기화
terraform refresh

# 변경 사항 확인
terraform plan
```

#### 변경 사항 공유하기

```bash
# 코드 포맷팅
terraform fmt -recursive

# 검증
terraform validate

# Git 커밋
git add .
git commit -m "feat: Add new EC2 instance for API server"
git push
```