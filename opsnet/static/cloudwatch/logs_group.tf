/* Database */

#Main
resource "aws_cloudwatch_log_group" "rds_error" {
  name = "/aws/rds/instance/gnudb/error"
  retention_in_days = "3"
}
resource "aws_cloudwatch_log_group" "rds_general" {
  name = "/aws/rds/instance/gnudb/general"
  retention_in_days = "3"
}
resource "aws_cloudwatch_log_group" "rds_audit" {
  name = "/aws/rds/instance/gnudb/audit"
  retention_in_days = "3"

}
#replica
resource "aws_cloudwatch_log_group" "rds_error_replica" {
  name = "/aws/rds/instance/gnudb-replica/error"
  retention_in_days = "3"

}
resource "aws_cloudwatch_log_group" "rds_general_replica" {
  name = "/aws/rds/instance/gnudb-replica/general"
  retention_in_days = "3"

}
resource "aws_cloudwatch_log_group" "rds_audit_replica" {
  name = "/aws/rds/instance/gnudb-replica/audit"
  retention_in_days = "3"

}

/* Server */

resource "aws_cloudwatch_log_group" "svr_messages" {
  name = "/var/log/messages"
  retention_in_days = "3"

}
resource "aws_cloudwatch_log_group" "svr_secure" {
  name = "/var/log/secure"
  retention_in_days = "3"

}
resource "aws_cloudwatch_log_group" "svr_audit" {
  name = "/var/log/audit/audit.log"
  retention_in_days = "3"

}

/* Cloud Trail */
resource "aws_cloudwatch_log_group" "cloud_Trail" {
  name = "cloudtrail"
  retention_in_days = "1"

}


