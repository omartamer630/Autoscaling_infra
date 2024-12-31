# EC2 Configurations in ASG
resource "aws_launch_template" "ec2s_app" {
  name_prefix   = "app-launch-template"
  image_id      = "ami-0182f373e66f89c85"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.private_key_ec2s_pair.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  network_interfaces {
    security_groups = [aws_security_group.HTTP-SG.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y python3
              echo "Hello, World from ASG" > /home/ec2-user/index.html
              cd /home/ec2-user
              python3 -m http.server 80 &
              EOF
  )
}

resource "aws_autoscaling_group" "asg_private_subnets" {
  launch_template {
    id      = aws_launch_template.ec2s_app.id
    version = "$Latest"
  }
  max_size            = 3
  min_size            = 2
  desired_capacity    = 2
  vpc_zone_identifier = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
  target_group_arns   = [aws_lb_target_group.alb_groups.arn]
  tag {
    key                 = "ASG"
    value               = "ASG_instance"
    propagate_at_launch = true
  }
  lifecycle {
    ignore_changes = [desired_capacity] # ignores any manual and automated change in ASG 
  }
}
