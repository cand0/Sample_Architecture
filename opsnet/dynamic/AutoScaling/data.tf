locals {
  web_count = 2
  ami = "ami-0f5ac55e46a9008f2"
  key_name = "greatstar_key"
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
    name = "tag:Name"
    values = ["${var.public_subnet_name[count.index]}"]
  }
}

data "aws_subnet" "private" {
  count = length(var.private_subnet_name)

  filter {
    name = "tag:Name"
    values = ["${var.private_subnet_name[count.index]}"]
  }
}


data "aws_alb" "gnualb-web" {
  name = "gnualb-web"
}

data "aws_alb_target_group" "alb_web_tg" {
  name = "cand0-gnuboard-target-group"
}