resource "aws_subnet" "public" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${var.environment}-public-subnet"
      Type = "public"
    },
    var.tags
  )
}

resource "aws_subnet" "private" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = merge(
    {
      Name = "${var.environment}-private-subnet"
      Type = "private"
    },
    var.tags
  )
}

# 퍼블릭 라우트 테이블
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "${var.environment}-public-rt"
    },
    var.tags
  )
}

# 인터넷 게이트웨이로의 퍼블릭 라우트
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

# 퍼블릭 서브넷과 퍼블릭 라우트 테이블 연결
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# 프라이빗 라우트 테이블
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "${var.environment}-private-rt"
    },
    var.tags
  )
}

# 프라이빗 서브넷과 프라이빗 라우트 테이블 연결
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
