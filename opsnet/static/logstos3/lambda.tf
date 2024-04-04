resource "aws_lambda_function" "lambda_logstos3" {
  count         = length(var.File)
  filename      = "code.zip"
  function_name = "code_${count.index}"
  role          = aws_iam_role.lambda_logstos3.arn

  source_code_hash = filebase64sha256("./code.zip")
  handler = "code.lambda_handler"

  runtime = "python3.9"
  environment {
    variables = {
      GROUP_NAME         = var.File[count.index]
      DESTINATION_BUCKET = "greatstar-logging",
      PERIOD             = "1"
    }
  }
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo-1" {
  count = length(var.File) - 4
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = "${element(aws_lambda_function.lambda_logstos3.*.id, count.index)}"
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.lambda_logstos3-1.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo-2" {
  count = length(var.File) - 5
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = "${element(aws_lambda_function.lambda_logstos3.*.id, count.index + 5)}"
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.lambda_logstos3-2.arn
}


resource "aws_iam_role" "lambda_logstos3" {
  name = "lambda_logstos3"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service" : [
            "lambda.amazonaws.com"
          ]
        }
        "Action": "sts:AssumeRole",
        "Condition": {}
      }
    ]
  })
}


resource "aws_iam_policy" "lambda_logstos3" {
  name = "lambda_logstos3"
  policy    = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "S3:*",
          "s3-object-lambda:*",
          "logs:*",
          "KMS:*"
        ],
        "Resource": [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_logstos3" {
  name       = "lambda_logstos3"
  policy_arn = "${aws_iam_policy.lambda_logstos3.id}"
  roles      = [aws_iam_role.lambda_logstos3.name]
}