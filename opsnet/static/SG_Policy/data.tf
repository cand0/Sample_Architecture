

data "aws_vpc" "whiteboard_vpc" {
  id = var.vpc_id
}

# web server
data "aws_security_group" "svr" {
  tags = {
    Name = "web"
    Envrionment = "ops"
  }
}

# web alb
data "aws_security_group" "alb" {
  tags = {
    Name = "alb"
    Envrionment = "ops"
  }
}

# web db


data "aws_security_group" "db" {
  tags = {
    Name = "db"
    Envrionment = "ops"
  }
}



# bastion
data "aws_security_group" "bastion" {
  tags = {
    Name = "bastion"
    Envrionment = "ops"
  }
}

#window
data "aws_security_group" "window" {
  tags = {
    Name = "window"
    Envrionment = "ops"
  }
}
data "aws_security_group" "con_linux" {
  tags = {
    Name = "con_linux"
    Envrionment = "ops"
  }
}
