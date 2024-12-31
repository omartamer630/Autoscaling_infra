resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_eip" "eip_for_natgw" {
  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "main_nat_gw" {
  allocation_id = aws_eip.eip_for_natgw.id
  subnet_id     = aws_subnet.public_subnet_b.id

  tags = {
    Name = "${var.env}-nat"
  }
  depends_on = [aws_internet_gateway.main_igw]
}
