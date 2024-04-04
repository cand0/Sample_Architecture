data "aws_vpc" "whiteboard_vpc" {
  id = var.vpc_id
}

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
