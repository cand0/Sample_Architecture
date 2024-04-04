resource "aws_vpc" "whiteboard_vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "ops_vpc"
    Environment = "ops"
  }
}


resource "aws_subnet" "public" {
  count = "${length(var.subnet_cidrs_public)}"
  vpc_id = "${aws_vpc.whiteboard_vpc.id}"

  cidr_block = "${var.subnet_cidrs_public[count.index]}"
  availability_zone = "${var.availability_zones[count.index]}"


  tags = {
    Name = "${var.public_subnet_name[count.index]}"
    Environment = "ops"
    Tier  = "public"
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  count = "${length(var.subnet_cidrs_private)}"
  vpc_id = "${aws_vpc.whiteboard_vpc.id}"
  cidr_block = "${var.subnet_cidrs_private[count.index]}"
  availability_zone = "${var.availability_zones[count.index]}"
  tags = {
    Name = "${var.private_subnet_name[count.index]}"
    Environment = "ops"
    Tier  = "private"
  }
}

resource "aws_internet_gateway" "igw-whiteboard_vpc" {
  vpc_id = "${aws_vpc.whiteboard_vpc.id}"
  tags = {
    Name = "igw-whiteboard_vpc"
    Environment = "ops"
  }
}

resource "aws_nat_gateway" "nat-whiteboard_vpc" {
  allocation_id = "${aws_eip.eip_nat_gateway.id}"
  subnet_id     = "${element(aws_subnet.public.*.id, 0)}"

  tags = {
    Name = "nat-whiteboard_vpc"
    Environment = "ops"
  }
}

resource "aws_eip" "eip_nat_gateway" {
  tags = {
    Name = "eip_nat_gateway"
    Environment = "ops"
  }
}