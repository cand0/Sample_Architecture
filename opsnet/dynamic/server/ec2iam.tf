resource "aws_iam_policy" "ec2_cloudwatch_policy" {
  name = "ec2_cloudwatch_policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ec2_cloudwatch_policy" {
  name       = "ec2_cloudwatch_policy"
  policy_arn = aws_iam_policy.ec2_cloudwatch_policy.arn
  roles      = ["${aws_iam_role.ec2_server_policy.name}"]
}


resource "aws_iam_role" "ec2_server_policy" {
  name = "ec2_server_policy"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_server" {
  name = "server_profile"
  role = aws_iam_role.ec2_server_policy.id
}
