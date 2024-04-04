resource "aws_vpc" "architect_vpc" {
  cidr_block = "192.170.0.0/16"
  tags = {
    Name = "archi_vpc"
    Environment = "architect"
  }
}

resource "aws_subnet" "architect_bastion" {
  vpc_id = aws_vpc.architect_vpc.id
  cidr_block = "192.170.0.0/24"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "architect_bastion_subnet"
    Environment = "architect"
  }
}

resource "aws_subnet" "architect_ops" {
  vpc_id = aws_vpc.architect_vpc.id
  cidr_block = "192.170.1.0/24"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "architect_ops_subnet"
    Environment = "architect"
  }
}

resource "aws_subnet" "architect_dev" {
  vpc_id = aws_vpc.architect_vpc.id
  cidr_block = "192.170.2.0/24"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "architect_dev_subnet"
    Environment = "architect"
  }
}


resource "aws_internet_gateway" "architect_igw" {
  vpc_id = "${aws_vpc.architect_vpc.id}"
  tags = {
    Name = "architect_igw"
    Environment = "architect"
  }
}

resource "aws_nat_gateway" "architect_nat" {
  allocation_id = "${aws_eip.architect_eip_nat_gateway.id}"
  subnet_id     = "${element(aws_subnet.architect_bastion.*.id, 0)}"

  tags = {
    Name = "architect_nat"
    Environment = "architect"
  }
}

resource "aws_eip" "architect_eip_nat_gateway" {
  tags = {
    Name = "architect_eip_nat_gateway"
    Environment = "architect"
  }
}
