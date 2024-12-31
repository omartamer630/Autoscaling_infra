# Security Group for private Subnets EC2
resource "aws_security_group" "sg_ssh_allowed" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "ec2s-sg"
  description = "Allow SSH access to EC2 in public subnet"
  tags = {
    Name = "${var.env}-sg-subnets"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2s_ingress_1" {
  security_group_id = aws_security_group.sg_ssh_allowed.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ec2s_ingress_2" {
  security_group_id = aws_security_group.sg_ssh_allowed.id
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "ec2s_egress" {
  security_group_id = aws_security_group.sg_ssh_allowed.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_security_group" "HTTP-SG" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add SSH ingress rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with a more restrictive CIDR if needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "HTTP-SG"
  }
}
