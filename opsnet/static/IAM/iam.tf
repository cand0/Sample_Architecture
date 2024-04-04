resource "aws_iam_user" "security_admin" {
  name = "security_admin"

  tags = {
    Name = "security_admin"
  }
}
resource "aws_iam_user_login_profile" "security_admin" {
  user    = "${aws_iam_user.security_admin.name}"
}
output "security_admin_password" {
  value = "${aws_iam_user_login_profile.security_admin.encrypted_password}"
}

resource "aws_iam_user" "security_manager" {
  name = "security_manager"

  tags = {
    Name = "security_manager"
  }
}

resource "aws_iam_user_login_profile" "security_manager" {
  user    = "${aws_iam_user.security_manager.name}"
}
output "password" {
  value = "${aws_iam_user_login_profile.security_manager.encrypted_password}"
}


resource "aws_iam_user" "architect_admin" {
  name = "architect_admin"

  tags = {
    Name = "architect_admin"
  }
}

resource "aws_iam_user_login_profile" "architect_admin" {
  user    = "${aws_iam_user.architect_admin.name}"
}
output "architect_admin_password" {
  value = "${aws_iam_user_login_profile.architect_admin.encrypted_password}"
}



resource "aws_iam_role" "security_manager" {
  name = "security_manager"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS" : "arn:aws:iam::569083195829:user/security_manager"
        },
        "Action": "sts:AssumeRole",
        "Condition": {}
      }
    ]
  })

  tags = {
    Name = "architect_admin"
  }
}

#참고 : https://docs.aws.amazon.com/aws-managed-policy/latest/reference/ReadOnlyAccess.html
resource "aws_iam_policy" "security_manager" {
  name        = "security_manager"
  path        = "/"
  description = "security_manager"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "KMSDeleteDeny",
        "Effect": "Deny",
        "Action": [
          "kms:Disable*",
          "kms:Delete*"
          ],
        "Resource": "*"
      },
      {
        "Sid": "Statement1",
        "Effect": "Allow",
        "Action": [
          "cloudwatch:Describe*",
          "cloudwatch:Get*",
          "cloudwatch:List*",
          "logs:Describe*",
          "logs:FilterLogEvents",
          "logs:Get*",
          "logs:ListTagsForResource",
          "logs:ListTagsLogGroup",
          "logs:StartLiveTail",
          "logs:StartQuery",
          "logs:StopLiveTail",
          "logs:StopQuery",
          "logs:TestMetricFilter",
          "cloudtrail:Describe*",
          "cloudtrail:Get*",
          "cloudtrail:List*",
          "cloudtrail:LookupEvents",
          "kms:*",
          "ec2:Describe*",
          "ec2:Get*",
          "elasticloadbalancing:Describe*",
          "tag:*",
          "iam:Generate*",
          "iam:Get*",
          "iam:List*",
          "iam:Simulate*",
          "autoscaling:Describe*",
          "guardduty:List*",
          "guardduty:Describe*",
          "guardduty:Get*",
          "s3:List*",
          "s3:Describe*",
          "s3:Get*",
          "Lambda:List*",
          "Lambda:Get*",
          "sns:Check*",
          "sns:Get*",
          "sns:List*",
          "sqs:Get*",
          "sqs:List*",
          "sqs:Receive*",
          "health:Describe*",
          "healthlake:DescribeFHIRDatastore",
          "healthlake:DescribeFHIRExportJob",
          "healthlake:DescribeFHIRImportJob",
          "healthlake:GetCapabilities",
          "healthlake:ListFHIRDatastores",
          "healthlake:ListFHIRExportJobs",
          "healthlake:ListFHIRImportJobs",
          "healthlake:ListTagsForResource",
          "healthlake:ReadResource",
          "healthlake:SearchWithGet",
          "healthlake:SearchWithPost",
          "rds:Describe*",
          "rds:Download*",
          "rds:List*",
          "backup:Describe*",
          "backup:Get*",
          "backup:List*"
        ],
        "Resource": "*",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": [
              "0.0.0.0/0"
            ]
          },
          "Bool": {"aws:ViaAWSService": "false"}
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "security_manager" {
  name       = "security_manager_attachment"
  policy_arn = "${aws_iam_policy.security_manager.arn}"
  roles      = ["${aws_iam_role.security_manager.name}"]
}



resource "aws_iam_role" "architect_admin" {
  name = "architect_admin"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS" : "${aws_iam_user.architect_admin.arn}"
        },
        "Action": "sts:AssumeRole",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": [
              "0.0.0.0/0"
            ]
          },
          "Bool": {"aws:ViaAWSService": "false"}
        }
      }
    ]
  })

  tags = {
    Name = "architect_admin"
  }
}

resource "aws_iam_policy" "architect_admin" {
  name        = "architect_admin"
  path        = "/"
  description = "architect_admin"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement":[
      {
        "Sid": "RDSDeleteDeny",
        "Effect": "Deny",
        "Action": "rds:DeleteDBInstance",
        "Resource": "*"
      },
      {
        "Sid": "Allow",
        "Effect": "Allow",
        "Action": [
          "cloudwatch:*",
          "logs:*",
          "cloudtrail:*",
          "kms:Describe*",
          "kms:Get*",
          "kms:List*",
          "ec2:*",
          "elasticloadbalancing:*",
          "tag:*",
          "iam:Generate*",
          "iam:Get*",
          "iam:List*",
          "iam:Simulate*",
          "autoscaling:*",
          "guardduty:*",
          "s3:*",
          "Lambda:*",
          "sns:*",
          "sqs:*",
          "health:*",
          "healthlake:*",
          "rds:*",
          "backup:*",
        ],
        "Resource": "*",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": [
              "0.0.0.0/0"
            ]
          },
          "Bool": {"aws:ViaAWSService": "false"}
        }
      }
    ]
  })
}


resource "aws_iam_policy_attachment" "architect_admin" {
  name       = "architect_admin_attachment"
  policy_arn = "${aws_iam_policy.architect_admin.arn}"
  roles      = ["${aws_iam_role.architect_admin.name}"]
}

resource "aws_iam_role" "security_admin" {
  name = "security_admin"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS" : "${aws_iam_user.security_admin.arn}"
        },
        "Action": "sts:AssumeRole",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": [
              "46.51.237.177/32"
            ]
          },
          "Bool": {"aws:ViaAWSService": "false"}
        }
      }
    ]
  })

  tags = {
    Name = "security_admin"
  }
}

resource "aws_iam_policy_attachment" "security_admin" {
  name       = "security_admin_attachment"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  roles      = ["${aws_iam_role.security_admin.name}"]
}
