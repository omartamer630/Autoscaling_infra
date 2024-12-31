resource "aws_vpc" "main_vpc" {
  cidr_block           = var.cidrs[0].cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.env}-${var.cidrs[0].name}"
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
  tags = {
    Name = "${var.env}-public-rtb"
  }
}

resource "aws_route_table_association" "associate_public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "associate_public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_nat_gw.id
  }
}

resource "aws_route_table_association" "associate_private_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_rtb.id
}

resource "aws_route_table_association" "associate_private_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_rtb.id
}
