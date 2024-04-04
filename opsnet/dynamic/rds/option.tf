

resource "aws_db_option_group" "rds" {
  name                     = "rds-main"
  option_group_description = "rds_optionGroup"
  engine_name              = "mysql"
  major_engine_version     = "8.0"

  option {
    option_name = "MARIADB_AUDIT_PLUGIN"
  }
}

