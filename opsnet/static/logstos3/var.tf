variable "File" {
  default = ["/aws/rds/instance/gnudb-replica/audit","/aws/rds/instance/gnudb-replica/error","/aws/rds/instance/gnudb-replica/general","/aws/rds/instance/gnudb/audit","/aws/rds/instance/gnudb/error", "/aws/rds/instance/gnudb-replica/general", "/var/log/audit/audit.log","/var/log/messages","/var/log/secure"]
}

variable "File_Name" {
  default = ["replica-audit","replica-error","replica-general","audit","error", "general", "audit.log","messages","secure"]
}
