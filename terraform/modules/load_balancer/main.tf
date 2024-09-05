resource "aws_lb" "runsabba_load_balancer" {
  name                       = "Runsabba-Load-Balancer"
  internal                   = false #internet-facing
  load_balancer_type         = "application"
  security_groups            = [var.lb_security_group_id]
  subnets                    = [var.runsabba_public_1_id, var.runsabba_public_2_id]
  enable_deletion_protection = false

  tags = {
    Name = "Runsabba-LB"
  }
}

resource "aws_lb_target_group" "runsabba_lb_tg" {
  name     = "runsabba-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.aws_vpc_id #this tells the VPC the TG will rreside. we specify the targets in the TG attachment resource blocks (Lines 30-40)
}

resource "aws_lb_listener" "runsabba_lb_listener" {
  load_balancer_arn = aws_lb.runsabba_load_balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward" #forwards the http traffic to the target group
    target_group_arn = aws_lb_target_group.runsabba_lb_tg.arn
  }
}
#adding my webservers to the ALB target group
resource "aws_lb_target_group_attachment" "runsabba_ws_1_attachment" {
  target_group_arn = aws_lb_target_group.runsabba_lb_tg.arn
  target_id        = var.web_server_1
  port             = 80
}

resource "aws_lb_target_group_attachment" "runsabba_ws_2_attachment" {
  target_group_arn = aws_lb_target_group.runsabba_lb_tg.arn
  target_id        = var.web_server_2
  port             = 80
}

