
resource "aws_network_interface" "dev_web_network_interface" {
  count = local.dev_web_count
  subnet_id   = "${element(data.aws_subnet.dev_private.*.id, count.index)}"
  private_ips = [element(["192.169.1.100", "192.169.2.100"], count.index)]
  security_groups = ["${data.aws_security_group.dev_web.id}"]
  tags = {
    Name = "dev_primary_network_interface"
  }
}

resource "aws_instance" "dev_web_server" {
  count         = local.dev_web_count
  ami           = local.dev_ami
  instance_type = "t3.micro"
  key_name = "greatstar_key"
  iam_instance_profile = "${data.aws_iam_instance_profile.dev_ec2_server.name}"

  network_interface {
    network_interface_id = "${element(aws_network_interface.dev_web_network_interface.*.id, count.index)}"
    device_index         = 0
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  tags ={
    Name = "dev_web"
    Environment = "Dev"
  }
}