resource "aws_kms_key" "storage_encrypt" {
  description = "storage encrypt key"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  tags = {
    Name = "cand0-storage_encrypt_key"
  }
}

resource "aws_kms_alias" "storage_encrypt" {
  name          = "alias/cand0-storage-encrypt-key"
  target_key_id = "${aws_kms_key.storage_encrypt.key_id}"
}


resource "aws_kms_key_policy" "cand0" {
  key_id = aws_kms_key.storage_encrypt.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "Key managed User Policy",
    "Statement": [
      {
        "Sid": "Enable IAM User Permissions",
        "Effect": "Allow",
        "Principal": {
          "AWS": [
            "arn:aws:iam::569083195829:user/security_admin",
            "arn:aws:iam::569083195829:user/cand0"
          ]
        },
        "Action": "kms:*",
        "Resource": "*"
      },
      {
        "Sid": "Security_manager",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::569083195829:user/security_manager"
        },
        "Action": [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Get*",
          "kms:TagResource",
          "kms:UntagResource"
        ],
        "Resource": "*"
      },
      {
        "Sid": "Using Key",
        "Effect": "Allow",
        "Principal": {
          "AWS": [
            "arn:aws:iam::569083195829:user/architect_admin",
            "arn:aws:iam::569083195829:role/ec2_server_policy"
          ],
          "Service" : [
            "logs.amazonaws.com",
            "cloudtrail.amazonaws.com",
          ]
        },
        "Action": [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource": "*"
      }
    ]
  })
}
