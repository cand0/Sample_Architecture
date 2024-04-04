locals {
  dev_web_count = 1
  dev_ami = "ami-0842923717ad5c00c"
  dev_key_name = "greatstar_key"
  dev_window_ami = "ami-0d862f7ba344bc551"
  dev_window_count = "2"
}

data "aws_vpc" "dev_whiteboard_vpc" {
  id = var.dev_vpc_id
}

data "aws_subnet" "dev_public" {
  count = length(var.dev_public_subnet_name)

  tags = {
    Name = "${var.dev_public_subnet_name[count.index]}"
    Environment = "dev"
    Tier  = "public"
  }
}

data "aws_subnet" "dev_private" {
  count = length(var.dev_private_subnet_name)

  tags = {
    Name = "${var.dev_private_subnet_name[count.index]}"
    Environment = "dev"
    Tier  = "private"
  }
}

data "aws_iam_instance_profile" "dev_ec2_server" {
  name = "server_profile"
}


#SG
data "aws_security_group" "dev_web" {
  tags = {
    Name = "web"
    Envrionment = "dev"
  }
}
data "aws_security_group" "dev_bastion" {
  tags = {
    Name = "bastion"
    Envrionment = "dev"
  }
}
data "aws_security_group" "dev_elb_sg" {
  tags = {
    Name = "alb"
    Envrionment = "dev"
  }
}