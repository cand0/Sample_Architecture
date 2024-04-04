# srcbucket & logging bucket

resource "aws_s3_bucket" "logging" {
  bucket = "greatstar-logging"

  object_lock_enabled = true

  tags = {
    Name = "logging_bucket"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "logging" {
  bucket = aws_s3_bucket.logging.id
  rule {
    id = "Access_log"
    filter {
      prefix = "Access_logs/"
    }
    transition {
      days          = 30
      storage_class = "GLACIER"
    }
    expiration {
      days          = 1095
    }
    status = "Enabled"
  }
  rule {
    id = "etc_log"

    filter {
      prefix = "etc_logs/"
    }
    transition {
      days          = 30
      storage_class = "GLACIER"
    }
    expiration {
      days          = 180
    }
    status = "Enabled"
  }
  rule {
    id = "server"
    filter {
      prefix = "server/"
    }
    transition {
      days          = 30
      storage_class = "GLACIER"
    }
    expiration {
      days          = 180
    }
    status = "Enabled"
  }
  rule {
    id = "bastion"
    filter {
      prefix = "bastion/"
    }
    transition {
      days          = 30
      storage_class = "GLACIER"
    }
    expiration {
      days          = 180
    }
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "srcbucket" {
  bucket = "greatstar-srcbucket"

  tags = {
    Name = "src_bucket"
  }
}

resource "aws_s3_bucket_versioning" "srcbucket" {
  bucket = "${aws_s3_bucket.srcbucket.id}"
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logging" {
  bucket = "${aws_s3_bucket.logging.id}"
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = data.aws_kms_key.storage_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}