

resource "aws_launch_template" "main" {
  name = "Asg_Web"
  image_id                = "${local.ami}"
  instance_type           = "t3.micro"
  iam_instance_profile {
    name = "server_profile"
  }
  key_name                = local.key_name
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "asg_web"
    }
  }
}

resource "aws_autoscaling_group" "main" {
  name                    = "greatstar_gusung"
  desired_capacity        = 1
  max_size                = 2
  min_size                = 0
  health_check_type       = "ELB"
  vpc_zone_identifier     = [data.aws_subnet.private[0].id, data.aws_subnet.private[1].id]
  launch_template {
    id        = aws_launch_template.main.id
    version   = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "main" {
  autoscaling_group_name    = aws_autoscaling_group.main.id
  lb_target_group_arn       = data.aws_alb_target_group.alb_web_tg.arn
}

resource "aws_autoscaling_policy" "scale-out" {
  autoscaling_group_name = "${aws_autoscaling_group.main.id}"
  name                   = "scale_out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
}

resource "aws_autoscaling_policy" "scale-in" {
  autoscaling_group_name = "${aws_autoscaling_group.main.id}"
  name                   = "scale_in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
}

