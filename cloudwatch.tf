resource "aws_cloudwatch_metric_alarm" "default" {
  alarm_name          = "terraform-test-ec2"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 50
  alarm_description   = "This metric monitors ec2 cpu utilization"

  alarm_actions = [
    aws_sns_topic.default.arn
  ]
}

resource "aws_sns_topic" "default" {
  name = "terraform-test-sns"
}

resource "aws_sns_topic_subscription" "default" {
  topic_arn = aws_sns_topic.default.arn
  protocol  = "email"
  endpoint  = var.adoress
}