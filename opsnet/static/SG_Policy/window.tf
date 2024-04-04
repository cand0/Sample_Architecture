resource "aws_ec2_managed_prefix_list" "console" {
  address_family = "IPv4"
  max_entries    = 15
  name           = "console"
}

/*resource "aws_ec2_managed_prefix_list_entry" "entry_1" {
  cidr           = "99.83.249.255/32"
  description    = "console"
  prefix_list_id = aws_ec2_managed_prefix_list.console.id
}
resource "aws_ec2_managed_prefix_list_entry" "entry_2" {
  cidr           = "75.2.36.229/32"
  description    = "console"
  prefix_list_id = aws_ec2_managed_prefix_list.console.id
}
resource "aws_ec2_managed_prefix_list_entry" "entry_3" {
  cidr           = "52.119.211.200/32"
  description    = "ap-northeast-2"
  prefix_list_id = aws_ec2_managed_prefix_list.console.id
}
resource "aws_ec2_managed_prefix_list_entry" "entry_4" {
  cidr           = "3.2.8.2/32"
  description    = "sign-in"
  prefix_list_id = aws_ec2_managed_prefix_list.console.id
}
resource "aws_ec2_managed_prefix_list_entry" "entry_5" {
  cidr           = "143.204.75.78/32"
  description    = "awsamazon-com"
  prefix_list_id = aws_ec2_managed_prefix_list.console.id
}
resource "aws_ec2_managed_prefix_list_entry" "entry_6" {
  cidr           = "3.3.12.1/32"
  description    = "ap-northeast-1"
  prefix_list_id = aws_ec2_managed_prefix_list.console.id
}
resource "aws_ec2_managed_prefix_list_entry" "entry_7" {
  cidr           = "3.3.13.1/32"
  description    = "ap-northeast-1"
  prefix_list_id = aws_ec2_managed_prefix_list.console.id
}
resource "aws_ec2_managed_prefix_list_entry" "entry_8" {
  cidr           = "54.64.82.82/32"
  description    = "ap-northeast-1-prod"
  prefix_list_id = aws_ec2_managed_prefix_list.console.id
}
resource "aws_ec2_managed_prefix_list_entry" "entry_9" {
  cidr           = "52.68.162.147/32"
  description    = "ap-northeast-1"
  prefix_list_id = aws_ec2_managed_prefix_list.console.id
}
resource "aws_ec2_managed_prefix_list_entry" "entry_10" {
  cidr           = "35.74.20.27/32"
  description    = "ap-northeast-1"
  prefix_list_id = aws_ec2_managed_prefix_list.console.id
}
resource "aws_ec2_managed_prefix_list_entry" "entry_11" {
  cidr           = "3.2.14.1/32"
  description    = "ap-northeast-1"
  prefix_list_id = aws_ec2_managed_prefix_list.console.id
}


resource "aws_vpc_security_group_egress_rule" "window" {
  security_group_id = data.aws_security_group.window.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 53
  ip_protocol = "tcp"
  to_port     = 53
}*/

resource "aws_vpc_security_group_egress_rule" "window_console" {
  security_group_id = data.aws_security_group.window.id

  prefix_list_id  = aws_ec2_managed_prefix_list.console.id
  ip_protocol     = -1
}

