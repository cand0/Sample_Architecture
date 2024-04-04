data "aws_kms_key" "storage_key" {
  key_id = "alias/cand0-storage-encrypt-key"
}
