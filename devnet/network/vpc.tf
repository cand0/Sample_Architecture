resource "aws_vpc" "dev_whiteboard_vpc" {
  cidr_block = "192.169.0.0/16"
  tags = {
    Name = "dev_vpc"
    Environment = "Dev"
  }
}

resource "aws_subnet" "dev_public" {
  count = "${length(var.dev_subnet_cidrs_public)}"
  vpc_id = "${aws_vpc.dev_whiteboard_vpc.id}"

  cidr_block = "${var.dev_subnet_cidrs_public[count.index]}"
  availability_zone = "${var.dev_availability_zones[count.index]}"


  tags = {
    Name = "${var.dev_public_subnet_name[count.index]}"
    Environment = "dev"
    Tier  = "public"
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "dev_private" {
  count = "${length(var.dev_subnet_cidrs_private)}"
  vpc_id = "${aws_vpc.dev_whiteboard_vpc.id}"
  cidr_block = "${var.dev_subnet_cidrs_private[count.index]}"
  availability_zone = "${var.dev_availability_zones[count.index]}"
  tags = {
    Name = "${var.dev_private_subnet_name[count.index]}"
    Environment = "dev"
    Tier  = "private"
  }
}

resource "aws_internet_gateway" "dev_igw-whiteboard_vpc" {
  vpc_id = "${aws_vpc.dev_whiteboard_vpc.id}"
  tags = {
    Name = "dev_igw-whiteboard_vpc"
    Environment = "Dev"
  }
}

resource "aws_nat_gateway" "dev_nat-whiteboard_vpc" {
  allocation_id = "${aws_eip.dev_eip_nat_gateway.id}"
  subnet_id     = "${element(aws_subnet.dev_public.*.id, 0)}"

  tags = {
    Name = "dev_nat-whiteboard_vpc"
    Environment = "dev"
  }
}

resource "aws_eip" "dev_eip_nat_gateway" {
  tags = {
    Name = "dev_eip_nat_gateway"
    Environment = "dev"
  }
}
