locals {
  # az_zones = var.az_zones
  public_subnet_cidrs  = [for i in range(var.public_subnet_count) : cidrsubnet(local.cidr_public, 4, i)]
  private_subnet_cidrs = [for i in range(var.private_subnet_count) : cidrsubnet(local.cidr_private, 4, i)]
}


resource "aws_subnet" "private" {
  count             = var.create_vpc ? var.private_subnet_count : 0
  vpc_id            = aws_vpc.custom1[0].id
  cidr_block        = local.private_subnet_cidrs[count.index]
  availability_zone = element(var.az_zones, count.index)
}

resource "aws_subnet" "public" {
  count             = var.create_vpc ? var.public_subnet_count : 0
  vpc_id            = aws_vpc.custom1[0].id
  cidr_block        = local.public_subnet_cidrs[count.index]
  availability_zone = element(var.az_zones, count.index)
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}


resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.custom1[0].id
  tags = {
    Name = "internet-gateway-for-public-subnets"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.custom1[0].id
  tags = {
    Name = "public-route-table"
  }
}


resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id 
}


resource "aws_route_table_association" "public_route_table_association" {
  count          = var.create_vpc ? var.public_subnet_count : 0
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}
