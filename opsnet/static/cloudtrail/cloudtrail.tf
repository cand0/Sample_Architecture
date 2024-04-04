data "aws_s3_bucket" "cloudtrail" {
  bucket = "greatstar-logging"
}

data "aws_cloudwatch_log_group" "cloudtrail" {
  name = "cloudtrail"
}

resource "aws_cloudtrail" "cloudtrail" {
  name           = "cloudtrail_logging"
  s3_bucket_name = "${data.aws_s3_bucket.cloudtrail.id}"
  s3_key_prefix = "Access_logs/cloudtrail"
  include_global_service_events = true
  is_multi_region_trail = true
  cloud_watch_logs_group_arn = "${data.aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn = "${aws_iam_role.cloudtrail_logs_group.arn}"

  depends_on = [aws_iam_role.cloudtrail_logs_group]
}


resource "aws_iam_role" "cloudtrail_logs_group" {
  name = "cloudtrail_logs_group"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service" : "cloudtrail.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "cloudtrail_logs_group"
  }
}


resource "aws_iam_policy" "cloudtrail_logs_group" {
  name        = "cloudtrail_logs_group"
  path        = "/"
  description = "cloudtrail_logs_group"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AWSCloudTrailCreateLogStream2014110",
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": ["*"
        ]
      }
    ]
  })
}


resource "aws_iam_policy_attachment" "cloudtrail_logs_group" {
  name       = "cloudtrail_logs_group"
  policy_arn = "${aws_iam_policy.cloudtrail_logs_group.arn}"
  roles      = ["${aws_iam_role.cloudtrail_logs_group.name}"]
}

