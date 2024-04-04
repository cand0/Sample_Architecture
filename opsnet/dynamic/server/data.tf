locals {
  web_count  = 2
  ami        = "ami-0f5ac55e46a9008f2"
  key_name   = "greatstar_key"
  window_ami = "ami-051616b1e416b0b74"
}

data "aws_kms_key" "storage_key" {
  key_id = "alias/cand0-storage-encrypt-key"
}

data "aws_vpc" "whiteboard_vpc" {
  id = var.vpc_id
}


data "aws_subnet" "public" {
  count = length(var.public_subnet_name)

  filter {
    name   = "tag:Name"
    values = ["${var.public_subnet_name[count.index]}"]
  }
  filter {
    name   = "tag:Environment"
    values = ["ops"]
  }
}

data "aws_subnet" "private" {
  count = length(var.private_subnet_name)

  filter {
    name   = "tag:Name"
    values = ["${var.private_subnet_name[count.index]}"]
  }
  filter {
    name   = "tag:Environment"
    values = ["ops"]
  }
}


#SG
data "aws_security_group" "web" {
  tags = {
    Name        = "web"
    Envrionment = "ops"
  }
}
data "aws_security_group" "bastion" {
  tags = {
    Name        = "bastion"
    Envrionment = "ops"
  }
}
data "aws_security_group" "elb_sg" {
  tags = {
    Name        = "alb"
    Envrionment = "ops"
  }
}

data "aws_security_group" "window" {
  tags = {
    Name        = "window"
    Envrionment = "ops"
  }
}
data "aws_security_group" "con_linux" {
  tags = {
    Name        = "con_linux"
    Envrionment = "ops"
  }
}