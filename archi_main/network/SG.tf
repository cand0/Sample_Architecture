

resource "aws_security_group" "ops_bastion" {
  vpc_id = aws_vpc.architect_vpc.id
  name = "ops_bastion"
  tags = {
    Name = "ops_bastion"
    Environment = "architect"
  }
}
resource "aws_security_group" "dev_architect" {
  vpc_id = aws_vpc.architect_vpc.id
  name = "dev_architect"
  tags = {
    Name = "dev_architect"
    Environment = "architect"
  }
}
resource "aws_security_group" "ops_architect" {
  vpc_id = aws_vpc.architect_vpc.id
  name = "ops_architect"
  tags = {
    Name = "ops_architect"
    Environment = "architect"
  }
}