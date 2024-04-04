resource "aws_route_table" "dev_whiteboard_public_table" {
  vpc_id = "${aws_vpc.dev_whiteboard_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dev_igw-whiteboard_vpc.id}"
  }
  tags = {
    Name = "whiteboard_public_table"
    Environment = "dev"
  }
}

resource "aws_route_table" "dev_whiteboard_private_table" {
  vpc_id = "${aws_vpc.dev_whiteboard_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.dev_nat-whiteboard_vpc.id}"
  }
  tags = {
    Name = "whiteboard_private_table"
    Environment = "dev"
  }
}

resource "aws_route_table_association" "dev_public" {
  count = "${length(var.dev_subnet_cidrs_public)}"

  subnet_id      = "${element(aws_subnet.dev_public.*.id, count.index)}"
  route_table_id = "${aws_route_table.dev_whiteboard_public_table.id}"
}

 
resource "aws_route_table_association" "dev_private" {
  count = "${length(var.dev_subnet_cidrs_private)}"

  subnet_id      = "${element(aws_subnet.dev_private.*.id, count.index)}"
  route_table_id = "${aws_route_table.dev_whiteboard_private_table.id}"
}