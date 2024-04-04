resource "aws_vpc_security_group_ingress_rule" "bastion_ssh" {
  security_group_id = data.aws_security_group.bastion.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "web_ssh" {
  security_group_id = data.aws_security_group.svr.id

  referenced_security_group_id = data.aws_security_group.bastion.id
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}


#rdp
resource "aws_vpc_security_group_ingress_rule" "bastion_rdp" {
  security_group_id = data.aws_security_group.bastion.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 3389
  ip_protocol = "tcp"
  to_port     = 3389
}

resource "aws_vpc_security_group_ingress_rule" "window" {
  security_group_id = data.aws_security_group.window.id

  referenced_security_group_id = data.aws_security_group.bastion.id
  from_port   = 3389
  ip_protocol = "tcp"
  to_port     = 3389
}

resource "aws_vpc_security_group_ingress_rule" "window2" {
  security_group_id = data.aws_security_group.con_linux.id

  referenced_security_group_id = data.aws_security_group.bastion.id
  from_port   = 3389
  ip_protocol = "tcp"
  to_port     = 3389
}



#db
resource "aws_vpc_security_group_ingress_rule" "db" {
  security_group_id = data.aws_security_group.db.id

  referenced_security_group_id = data.aws_security_group.con_linux.id
  from_port   = 3306
  ip_protocol = "tcp"
  to_port     = 3306
}
