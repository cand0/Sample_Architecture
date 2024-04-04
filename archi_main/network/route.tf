resource "aws_route_table" "architect_bastion" {
  vpc_id = aws_vpc.architect_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.architect_igw.id}"
  }
  tags = {
    Name = "architect_bastion"
    Environment = "architect"
  }
}
resource "aws_route_table" "architect_ops" {
  vpc_id = aws_vpc.architect_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.architect_nat.id}"
  }
  tags = {
    Name = "architect_ops"
    Environment = "architect"
  }
}
resource "aws_route_table" "architect_dev" {
  vpc_id = aws_vpc.architect_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.architect_nat.id}"
  }
  tags = {
    Name = "architect_dev"
    Environment = "architect"
  }
}

resource "aws_route_table_association" "architect_bastion" {
  route_table_id = "${aws_route_table.architect_bastion.id}"
  subnet_id = "${aws_subnet.architect_bastion.id}"
}
resource "aws_route_table_association" "architect_ops" {
  route_table_id = "${aws_route_table.architect_ops.id}"
  subnet_id = "${aws_subnet.architect_ops.id}"
}
resource "aws_route_table_association" "architect_dev" {
  route_table_id = "${aws_route_table.architect_dev.id}"
  subnet_id = "${aws_subnet.architect_dev.id}"
}

