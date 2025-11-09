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

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "${var.environment}-public-rt"
    },
    var.tags
  )
}

# Public Route to Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "${var.environment}-private-rt"
    },
    var.tags
  )
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
