resource "aws_route_table" "whiteboard_public_table" {
  vpc_id = "${aws_vpc.whiteboard_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw-whiteboard_vpc.id}"
  }
  tags = {
    Name = "whiteboard_public_table"
    Environment = "ops"
  }
}

resource "aws_route_table" "whiteboard_private_table" {
  vpc_id = "${aws_vpc.whiteboard_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat-whiteboard_vpc.id}"
  }
  tags = {
    Name = "whiteboard_private_table"
    Environment = "ops"
  }
}

resource "aws_route_table_association" "public" {
  count = "${length(var.subnet_cidrs_public)}"

  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.whiteboard_public_table.id}"
}

 
resource "aws_route_table_association" "private" {
  count = "${length(var.subnet_cidrs_private)}"

  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.whiteboard_private_table.id}"
}