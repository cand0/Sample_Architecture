resource "aws_db_option_group" "dev_rds" {
  name                     = "dev-rds-option"
  option_group_description = "dev_rds_optionGroup"
  engine_name              = "mysql"
  major_engine_version     = "8.0"

  option {
    option_name = "MARIADB_AUDIT_PLUGIN"
  }
}