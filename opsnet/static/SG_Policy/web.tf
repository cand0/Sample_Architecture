resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = data.aws_security_group.alb.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "svr_http" {
  security_group_id = data.aws_security_group.svr.id

  referenced_security_group_id = data.aws_security_group.alb.id
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}


resource "aws_vpc_security_group_ingress_rule" "svr_db" {
  security_group_id = data.aws_security_group.db.id

  referenced_security_group_id = data.aws_security_group.svr.id
  from_port   = 3306
  ip_protocol = "tcp"
  to_port     = 3306
}


