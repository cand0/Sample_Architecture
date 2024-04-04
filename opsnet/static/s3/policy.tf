resource "aws_s3_bucket_policy" "logging" {
  bucket = "${aws_s3_bucket.logging.id}"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "LogstoS3_bucket",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "logs.amazonaws.com",
            "cloudtrail.amazonaws.com"
          ]
        },
        "Action": [
          "s3:GetBucketAcl"

        ],
        "Resource": "arn:aws:s3:::greatstar-logging"
      },
      {
        "Sid": "LogstoS3_Object",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "logs.amazonaws.com",
            "cloudtrail.amazonaws.com"
          ]
        },
        "Action": [
          "s3:PutObject"

        ],
        "Resource": [
          "arn:aws:s3:::greatstar-logging/Access_logs/*",
          "arn:aws:s3:::greatstar-logging/etc_logs/*"
        ]
      },
      {
        "Sid": "EC2toS3_bucket",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::569083195829:role/ec2_server_policy"
        },
        "Action": "s3:GetBucketAcl",
        "Resource": "arn:aws:s3:::greatstar-logging"
      },
      {
        "Sid": "EC2toS3_Object",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::569083195829:role/ec2_server_policy"
        },
        "Action": "s3:PutObject",
        "Resource": [
          "arn:aws:s3:::greatstar-logging/etc_logs/*",
          "arn:aws:s3:::greatstar-logging/server/*",
          "arn:aws:s3:::greatstar-logging/bastion/*"
        ]
      }
    ]
  })
}


resource "aws_s3_bucket_policy" "srcbucket" {
  bucket = "${aws_s3_bucket.srcbucket.id}"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "bucket dev&ops",
        "Effect": "Allow",
        "Principal": {
          "AWS": [
            "arn:aws:iam::569083195829:role/architect_policy",
            "arn:aws:iam::569083195829:role/ec2_server_policy"
            ]
        },
        "Action": [
          "s3:GetBucketAcl",
          "s3:ListBucket"
        ],
        "Resource": "arn:aws:s3:::greatstar-srcbucket"
      },
      {
        "Sid": "object dev&ops",
        "Effect": "Allow",
        "Principal": {
          "AWS": [
            "arn:aws:iam::569083195829:role/architect_policy",
            "arn:aws:iam::569083195829:role/ec2_server_policy"
          ]
        },
        "Action": [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Resource": [
          "arn:aws:s3:::greatstar-srcbucket/dev/*",
          "arn:aws:s3:::greatstar-srcbucket/ops/*",
          "arn:aws:s3:::greatstar-srcbucket/web/*",
        ]
      }
    ]
  })
}