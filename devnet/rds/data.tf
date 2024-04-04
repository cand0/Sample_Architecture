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

data "aws_security_group" "dev_rds_sg" {
  tags = {
    Name = "db"
    Envrionment = "dev"
  }
}