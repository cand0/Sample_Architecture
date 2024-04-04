// !! RDS -> Storage Autoscaling 확인하기

resource "aws_db_instance" "dev_gnu_db" {
  identifier             = "dev-gnudb"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0.32"
  username               = "admin"
  password               = "adminadmin"
  db_subnet_group_name   = aws_db_subnet_group.dev_gnu_db_subnet.name
  vpc_security_group_ids = [data.aws_security_group.dev_rds_sg.id]
  parameter_group_name   = aws_db_parameter_group.dev_gnudb_param.name
  backup_retention_period = 7
  publicly_accessible    = false
  skip_final_snapshot    = true
  option_group_name = aws_db_option_group.dev_rds.name

  enabled_cloudwatch_logs_exports = ["audit", "error", "general"]
  tags = {
    Name = "dev_Main_DB"
    Environment = "dev"
  }
}

resource "aws_db_parameter_group" "dev_gnudb_param" {
  name   = "dev-gnudbparam"
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


resource "aws_db_subnet_group" "dev_gnu_db_subnet" {
  name       = "dev_rds_main"
  subnet_ids = ["${element(data.aws_subnet.dev_private.*.id, 2)}","${element(data.aws_subnet.dev_private.*.id, 3)}"]

  tags = {
    Name = "My DB subnet group"
    Environment = "dev"
  }
}
