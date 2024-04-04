
resource "aws_network_interface" "web_network_interface" {
  count           = local.web_count
  subnet_id       = element(data.aws_subnet.private.*.id, count.index)
  private_ips     = [element(["192.168.1.100", "192.168.2.100"], count.index)]
  security_groups = ["${data.aws_security_group.web.id}"]
  tags = {
    Name = "primary_network_interface"
  }
}


resource "aws_instance" "web_server" {
  count                = local.web_count
  ami                  = local.ami
  instance_type        = "t3.micro"
  key_name             = "greatstar_key"
  iam_instance_profile = aws_iam_instance_profile.ec2_server.name

  network_interface {
    network_interface_id = element(aws_network_interface.web_network_interface.*.id, count.index)
    device_index         = 0
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  root_block_device {
    encrypted  = true
    kms_key_id = data.aws_kms_key.storage_key.arn
  }
  tags = {
    Name = "web"
  }
}