locals {
  ami = "ami-0f24ce5b32d20d7bf"
  key_name = "greatstar_key"
}

data "aws_kms_key" "storage_key" {
  key_id = "alias/cand0-storage-encrypt-key"
}

data "aws_vpc" "whiteboard_vpc" {
  id = var.vpc_id
}


data "aws_subnet" "architect_bastion_subnet" {
  tags = {
    Name = "architect_bastion_subnet"
    Environment = "architect"
  }
}
data "aws_subnet" "architect_ops" {
  tags = {
    Name = "architect_ops_subnet"
    Environment = "architect"
  }
}
data "aws_subnet" "architect_dev" {
  tags = {
    Name = "architect_dev_subnet"
    Environment = "architect"
  }
}



#SG
data "aws_security_group" "ops_bastion" {
  tags = {
    Name = "ops_bastion"
    Environment = "architect"
  }
}
data "aws_security_group" "ops_architect" {
  tags = {
    Name = "ops_architect"
    Environment = "architect"
  }
}
data "aws_security_group" "dev_architect" {
  tags = {
    Name = "dev_architect"
    Environment = "architect"
  }
}
