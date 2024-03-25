# create application load balancer
resource "aws_lb" "lb_load_balancer" {
  name                       = "alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.lb_security_group.id]
  subnets                    = aws_subnet.public_subnets[*].id //[var.public_subnets_id[0]]
  enable_deletion_protection = false

  tags = {
    Name = "hr-app-alb"
  }
}

# create target group
resource "aws_lb_target_group" "lb_target_group" {
  name        = "lb"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.test_vpc.id

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}

# create a listener on port 80 with forward action
resource "aws_lb_listener" "lb_https_listener" {
  load_balancer_arn = aws_lb.lb_load_balancer.arn
  port              = 80
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}