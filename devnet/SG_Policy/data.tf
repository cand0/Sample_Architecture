

data "aws_vpc" "dev_whiteboard_vpc" {
  id = var.dev_vpc_id
}

# web server
data "aws_security_group" "dev_svr" {
  tags = {
    Name = "web"
    Envrionment = "dev"
  }
}

# web alb
data "aws_security_group" "dev_alb" {
  tags = {
    Name = "alb"
    Envrionment = "dev"
  }
}

# web db

data "aws_security_group" "dev_db" {
  tags = {
    Name = "db"
    Envrionment = "dev"
  }
}


# bastion
data "aws_security_group" "dev_bastion" {
  tags = {
    Name = "bastion"
    Envrionment = "dev"
  }
}