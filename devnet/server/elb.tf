resource "aws_alb_target_group" "dev_alb_web_tg" {
  name     = "dev-cand0-gnuboard-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${data.aws_vpc.dev_whiteboard_vpc.id}"

  health_check {
    interval            = 30
    path                = "/gnuboard"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = { Name = "dev_Gnuboard Target Group" }
}

resource "aws_alb_target_group_attachment" "dev_alb_tg_web" {
  count            = local.dev_web_count
  target_group_arn = "${aws_alb_target_group.dev_alb_web_tg.arn}"
  target_id        = "${element(aws_instance.dev_web_server.*.id, count.index)}"
  port             = 80
}


resource "aws_alb" "dev_gnualb_web" {
  name            = "dev-gnualb-web"
  internal        = false
  security_groups = ["${data.aws_security_group.dev_elb_sg.id}"]
  subnets         = [
    "${element(data.aws_subnet.dev_public.*.id, 0)}",
    "${element(data.aws_subnet.dev_public.*.id, 1)}"
  ]
  tags = {
    Name = "dev_gnualb_web"
  }
  lifecycle { create_before_destroy = true }
}


resource "aws_alb_listener" "dev_http" {
  load_balancer_arn = "${aws_alb.dev_gnualb_web.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.dev_alb_web_tg.arn}"
    type             = "forward"
  }
}