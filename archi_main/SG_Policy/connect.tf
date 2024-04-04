resource "aws_vpc_security_group_ingress_rule" "ops_bastion" {
  security_group_id = data.aws_security_group.ops_bastion.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "ops_architect" {
  security_group_id = data.aws_security_group.ops_architect.id

  referenced_security_group_id = data.aws_security_group.ops_bastion.id
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "dev_architect" {
  security_group_id = data.aws_security_group.dev_architect.id

  referenced_security_group_id = data.aws_security_group.ops_bastion.id
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

