resource "aws_security_group" "dev_main_web_server_sg" {
  vpc_id = aws_vpc.dev_whiteboard_vpc.id
  name = "main_web_server_sg"
  tags = {
    Name = "web"
    Envrionment = "dev"
  }
}

resource "aws_security_group" "dev_bastion" {
  vpc_id = aws_vpc.dev_whiteboard_vpc.id
  description = "bastion"

  tags = {
    Name = "bastion"
    Envrionment = "dev"
  }
}

resource "aws_security_group" "dev_elb_sg" {
  vpc_id = aws_vpc.dev_whiteboard_vpc.id
  name = "alb_sg"
  tags = {
    Name = "alb"
    Envrionment = "dev"
  }
}

resource "aws_security_group" "dev_rds_sg" {
  name = "dev_rds_sg"
  vpc_id = aws_vpc.dev_whiteboard_vpc.id

  tags = {
    Name = "db"
    Envrionment = "dev"
  }

}
