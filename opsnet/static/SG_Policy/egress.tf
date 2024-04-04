resource "aws_vpc_security_group_egress_rule" "alb" {
  security_group_id = data.aws_security_group.alb.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}


resource "aws_vpc_security_group_egress_rule" "svr" {
  security_group_id = data.aws_security_group.svr.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}


resource "aws_vpc_security_group_egress_rule" "bastion" {
  security_group_id = data.aws_security_group.bastion.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

resource "aws_vpc_security_group_egress_rule" "db" {
  security_group_id = data.aws_security_group.db.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

resource "aws_vpc_security_group_egress_rule" "windows" {
  security_group_id = data.aws_security_group.window.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}
