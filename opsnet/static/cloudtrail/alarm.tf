resource "aws_cloudwatch_log_metric_filter" "create_user" {
  log_group_name = "${data.aws_cloudwatch_log_group.cloudtrail.name}"
  name           = "cloudtrail_user"
  pattern        = "{ $.eventName = \"CreateUser\" }"

  metric_transformation {
    name      = "CreateUser"
    namespace = "CreateUser"
    value     = "1"
    unit = "Count"
  }
}

resource "aws_cloudwatch_metric_alarm" "create_user" {
  alarm_name          = "CreateUser"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name = "CreateUser"
  namespace = "CreateUser"
  statistic = "Sum"
  threshold = 1
  period = "60"

  alarm_actions = [aws_sns_topic.create_user.arn]
}

/*
resource "aws_cloudwatch_metric_alarm" "cpu-down" {
  alarm_name          = "svr_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "30"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }

  alarm_actions = [aws_autoscaling_policy.scale-in.arn]
}*/
