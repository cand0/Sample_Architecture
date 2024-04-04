resource "aws_vpc_endpoint" "s3_endpoint" {
  service_name = "com.amazonaws.ap-northeast-1.s3"
  vpc_id       = aws_vpc.architect_vpc.id
  tags = {
    Name = "ops_s3_endpoint"
    Environment = "ops"
  }
}

resource "aws_vpc_endpoint_route_table_association" "architect_bastion" {
  route_table_id  = "${aws_route_table.architect_bastion.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.s3_endpoint.id}"
}
resource "aws_vpc_endpoint_route_table_association" "architect_dev" {
  route_table_id  = "${aws_route_table.architect_dev.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.s3_endpoint.id}"
}
