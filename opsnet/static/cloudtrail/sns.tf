resource "aws_sns_topic" "create_user" {
  name = "create_user"
}

resource "aws_sns_topic_subscription" "create_user" {
  topic_arn = "${aws_sns_topic.create_user.arn}"
  protocol  = "email"
  endpoint  = "cando@mz.co.kr"
}

