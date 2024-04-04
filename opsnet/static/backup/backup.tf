data "aws_kms_key" "storage_key" {
  key_id = "alias/cand0-storage-encrypt-key"
}

resource "aws_backup_vault" "backup" {
  name              = "backup"
  kms_key_arn       = "${data.aws_kms_key.storage_key.arn}"
}

resource "aws_backup_plan" "backup" {
  name = "backup_plan"
  rule {
    rule_name         = "rds_backup"
    target_vault_name = aws_backup_vault.backup.name
    schedule          = "cron(00 00 * * ? *)"

    lifecycle {
      delete_after = 180
    }
  }
}


resource "aws_backup_selection" "rds" {
  iam_role_arn = "${aws_iam_role.backup.arn}"
  name         = "rds_backup"
  plan_id      = "${aws_backup_plan.backup.id}"
  resources    = ["*"]
  condition {
    string_equals {
      key   = "aws:ResourceTag/Backup"
      value = "true"
    }
  }
}
