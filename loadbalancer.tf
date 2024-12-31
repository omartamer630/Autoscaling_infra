resource "aws_lb" "alb_to_asg_ec2" {
  name                       = "alb-configuration"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.HTTP-SG.id]
  subnets                    = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
  enable_deletion_protection = false

  tags = {
    Name = "${var.env}-alb"
  }
}

# Create Target Group
resource "aws_lb_target_group" "alb_groups" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  health_check {
    port     = 80
    protocol = "HTTP"
    path     = "/"
  }

  tags = {
    Name = "${var.env}-alb"
  }
}

# Create Listener for ALB
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb_to_asg_ec2.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_groups.arn
  }
}
