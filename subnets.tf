resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.cidrs[1].cidr
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "${var.env}-${var.cidrs[1].name}"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.cidrs[3].cidr
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "${var.env}-${var.cidrs[3].name}"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.cidrs[2].cidr
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "${var.env}-${var.cidrs[2].name}"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.cidrs[4].cidr
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = "${var.env}-${var.cidrs[4].name}"
  }
}
