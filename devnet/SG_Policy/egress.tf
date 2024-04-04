resource "aws_vpc_security_group_egress_rule" "dev_alb" {
  security_group_id = data.aws_security_group.dev_alb.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}


resource "aws_vpc_security_group_egress_rule" "dev_svr" {
  security_group_id = data.aws_security_group.dev_svr.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}


resource "aws_vpc_security_group_egress_rule" "dev_bastion" {
  security_group_id = data.aws_security_group.dev_bastion.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

resource "aws_vpc_security_group_egress_rule" "dev_db" {
  security_group_id = data.aws_security_group.dev_db.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}
