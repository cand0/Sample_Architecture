resource "aws_security_group" "main_web_server_sg" {
  vpc_id = aws_vpc.whiteboard_vpc.id
  name = "main_web_server_sg"
  tags = {
    Name = "web"
    Envrionment = "ops"
  }
}

resource "aws_security_group" "bastion" {
  vpc_id = aws_vpc.whiteboard_vpc.id
  description = "bastion"

  tags = {
    Name = "bastion"
    Envrionment = "ops"
  }
}

resource "aws_security_group" "elb_sg" {
  vpc_id = aws_vpc.whiteboard_vpc.id
  name = "alb_sg"
  tags = {
    Name = "alb"
    Envrionment = "ops"
  }
}

resource "aws_security_group" "window" {
  vpc_id = aws_vpc.whiteboard_vpc.id
  description = "window"
  tags = {
    Name = "window"
    Envrionment = "ops"
  }
}

resource "aws_security_group" "con_linux" {
  vpc_id = aws_vpc.whiteboard_vpc.id
  description = "con_linux"

  tags = {
    Name = "con_linux"
    Envrionment = "ops"
  }
}

resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  vpc_id = aws_vpc.whiteboard_vpc.id

  tags = {
    Name = "db"
    Envrionment = "ops"
  }

}
