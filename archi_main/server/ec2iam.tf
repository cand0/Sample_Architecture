

resource "aws_iam_role" "architect_policy" {
  name = "architect_policy"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service" : "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole",
        "Condition": {}
      }
    ]
  })
}

resource "aws_iam_instance_profile" "architect_policy" {
  name = "architect_policy"
  role  = "${aws_iam_role.architect_policy.id}"
}
