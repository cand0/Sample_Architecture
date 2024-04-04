resource "aws_vpc_security_group_egress_rule" "ops_bastion" {
  security_group_id = data.aws_security_group.ops_bastion.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}


resource "aws_vpc_security_group_egress_rule" "ops_architect" {
  security_group_id = data.aws_security_group.ops_architect.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

resource "aws_vpc_security_group_egress_rule" "dev_architect" {
  security_group_id = data.aws_security_group.dev_architect.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

