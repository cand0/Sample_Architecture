// !! RDS -> Storage Autoscaling 확인하기


resource "aws_db_instance" "gnu_db_replica" {
  identifier              = "gnudb-replica"
  resource "aws_db_instance" "gnu_db" {
    identifier              = "gnudb"
    instance_class          = "db.t3.micro"
    allocated_storage       = 20
    engine                  = "mysql"
    engine_version          = "8.0.32"
    username                = "admin"
    password                = "adminadmin"
    db_subnet_group_name    = aws_db_subnet_group.gnu_db_subnet.name
    vpc_security_group_ids  = [data.aws_security_group.rds_sg.id]
    parameter_group_name    = aws_db_parameter_group.gnudb_param.name
    backup_retention_period = 7
    multi_az                = true
    publicly_accessible     = false
    skip_final_snapshot     = true
    storage_encrypted       = true
    kms_key_id              = data.aws_kms_key.storage_key.arn

    option_group_name = aws_db_option_group.rds.name

    enabled_cloudwatch_logs_exports = ["audit", "error", "general"]
    tags = {
      Name        = "Main_DB"
      Environment = "ops"
      Backup      = "true"
    }
  }
  instance_class          = "db.t3.micro"
  engine                  = "mysql"
  engine_version          = "8.0.32"
  db_subnet_group_name    = aws_db_subnet_group.gnu_db_subnet.name
  vpc_security_group_ids  = [data.aws_security_group.rds_sg.id]
  parameter_group_name    = aws_db_parameter_group.gnudb_param.name
  backup_retention_period = 7
  publicly_accessible     = false
  skip_final_snapshot     = true
  storage_encrypted       = true
  kms_key_id              = data.aws_kms_key.storage_key.arn

  #  option_group_name = aws_db_option_group.rds.name

  enabled_cloudwatch_logs_exports = ["audit", "error", "general"]
  replicate_source_db             = aws_db_instance.gnu_db.arn

  depends_on = [aws_db_instance.gnu_db]

}


resource "aws_db_parameter_group" "gnudb_param" {
  name   = "gnudbparam"
  family = "mysql8.0"

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
  parameter {
    name  = "character_set_connection"
    value = "utf8"
  }
  parameter {
    name  = "character_set_database"
    value = "utf8"
  }
  parameter {
    name  = "character_set_filesystem"
    value = "utf8"
  }
  parameter {
    name  = "character_set_results"
    value = "utf8"
  }
  parameter {
    name  = "character_set_server"
    value = "utf8"
  }
  parameter {
    name  = "log_output"
    value = "FILE"
  }
  parameter {
    name  = "general_log"
    value = "1"
  }
  parameter {
    name  = "wait_timeout"
    value = "900"
  }
  parameter {
    name  = "validate_password_policy"
    value = "MEDIUM"
  }
  parameter {
    name  = "default_password_lifetime"
    value = "182"
  }
  parameter {
    name  = "validate_password_length"
    value = "8"
  }
  parameter {
    name  = "password_history"
    value = "1"
  }
}


resource "aws_db_subnet_group" "gnu_db_subnet" {
  name       = "rds_main"
  subnet_ids = ["${element(data.aws_subnet.private.*.id, 2)}", "${element(data.aws_subnet.private.*.id, 3)}"]

  tags = {
    Name = "My DB subnet group"
  }
}

