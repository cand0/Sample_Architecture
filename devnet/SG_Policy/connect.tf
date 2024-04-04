resource "aws_vpc_security_group_ingress_rule" "dev_bastion_ssh" {
  security_group_id = data.aws_security_group.dev_bastion.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "dev_web_ssh" {
  security_group_id = data.aws_security_group.dev_svr.id

  referenced_security_group_id = data.aws_security_group.dev_bastion.id
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

#db
resource "aws_vpc_security_group_ingress_rule" "dev_db" {
  security_group_id = data.aws_security_group.dev_db.id

  referenced_security_group_id = data.aws_security_group.dev_db.id
  from_port   = 3306
  ip_protocol = "tcp"
  to_port     = 3306
}