resource "aws_alb" "alb-ext" {
  name            = "${local.MyName}-alb-ext"
  internal        = false
  security_groups = [
    aws_security_group.sg-alb.id
  ]
  subnets = [
    aws_subnet.sbn-public-a.id,
    aws_subnet.sbn-public-c.id
  ]
  tags = {
    Name = "${local.MyName}-alb-ext"
  }
}


resource "aws_alb_target_group" "tg-web-80" {
  name = "${local.MyName}-alb-ext"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.cand1.id
  target_type = "ip"
  health_check {
    path = "/"
  }
  tags = {
    Name = "${local.MyName}-tg-mzc-80"
  }
}

resource "aws_alb_target_group" "tg-mzc-8080" {
  name = "${local.MyName}-mzc-8080"
  port = 8080
  protocol = "HTTP"
  vpc_id = aws_vpc.cand1.id
  target_type = "ip"
  health_check {
    path = "/mzc/"
  }
  tags = {
    Name = "${local.MyName}-tg-mzc-8080"
  }
}

resource "aws_alb_target_group" "tg-hashicorp-8080" {
  name = "${local.MyName}-hashicorp-8080"
  port = 8080
  protocol = "HTTP"
  vpc_id = aws_vpc.cand1.id
  target_type = "ip"
  health_check {
    path = "/hashicorp/"
  }
  tags = {
    Name = "${local.MyName}-tg-hashicorp-8080"
  }
}

resource "aws_alb_listener" "tg-web-80" {
  load_balancer_arn = aws_alb.alb-ext.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.tg-web-80.arn
    type             = "forward"
  }
}
resource "aws_lb_listener_rule" "cand1" {
  listener_arn = aws_alb_listener.tg-web-80.id
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg-hashicorp-8080.arn
  }

  condition {
    path_pattern {
      values = ["/mzc*"]
    }
  }
}


resource "aws_lb_listener_rule" "cand2" {
  listener_arn = aws_alb_listener.tg-web-80.id
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg-hashicorp-8080.arn
  }

  condition {
    path_pattern {
      values = ["/hashicorp*"]
    }
  }
}

