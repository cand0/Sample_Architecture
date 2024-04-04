#https://jaffarshaik.medium.com/autoscaling-ec2-instances-based-on-cpu-usage-using-terraform-9c12edf6c1d5

resource "aws_cloudwatch_metric_alarm" "cpu-up" {
  alarm_name          = "svr_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "70"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }

  alarm_actions = [aws_autoscaling_policy.scale-out.arn]
}

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
}


