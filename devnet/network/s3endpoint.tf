resource "aws_vpc_endpoint" "dev_s3_endpoint" {
  service_name = "com.amazonaws.ap-northeast-1.s3"
  vpc_id       = aws_vpc.dev_whiteboard_vpc.id
  tags = {
    Name = "dev_s3_endpoint"
    Environment = "dev"
  }
}

#resource "aws_vpc_endpoint_subnet_association" "s3_endpoint" {
#  subnet_id       = "${aws_subnet.private[1].id}"
#  vpc_endpoint_id = "${aws_vpc_endpoint.s3_endpoint.id}"
#}
#
resource "aws_vpc_endpoint_route_table_association" "dev_private_s3_endpoint" {
  route_table_id  = "${aws_route_table.dev_whiteboard_private_table.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.dev_s3_endpoint.id}"
}
resource "aws_vpc_endpoint_route_table_association" "dev_public_s3_endpoint" {
  route_table_id  = "${aws_route_table.dev_whiteboard_public_table.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.dev_s3_endpoint.id}"
}