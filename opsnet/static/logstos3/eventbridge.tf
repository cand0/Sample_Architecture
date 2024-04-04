resource "aws_cloudwatch_event_rule" "lambda_logstos3-1" {
  name                = "lambda_logstos3-1"
  description         = "lambda_logstos3-1"
  schedule_expression = "cron(00 00 * * ? *)"
}
resource "aws_cloudwatch_event_rule" "lambda_logstos3-2" {
  name                = "lambda_logstos3-2"
  description         = "lambda_logstos3-2"
  schedule_expression = "cron(00 00 * * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_logstos3-1" {
  count     = length(var.File) - 4
  rule      = "${element(aws_cloudwatch_event_rule.lambda_logstos3-1.*.name, count.index)}"
  target_id = "code_${count.index}"
  arn       = "${element(aws_lambda_function.lambda_logstos3.*.arn, count.index)}"
}

resource "aws_cloudwatch_event_target" "lambda_logstos3-2" {
  count     = length(var.File) - 5
  rule      = "${element(aws_cloudwatch_event_rule.lambda_logstos3-2.*.name, count.index + 5)}"
  target_id = "code_${count.index + 5}"
  arn       = "${element(aws_lambda_function.lambda_logstos3.*.arn, 5 + count.index)}"
}

