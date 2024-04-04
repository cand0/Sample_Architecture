resource "aws_network_interface" "window" {
  subnet_id       = data.aws_subnet.private[4].id
  private_ips     = ["192.168.5.100"]
  security_groups = [data.aws_security_group.window.id]
  tags = {
    Name = "Window_network_interface"
  }
}


resource "aws_instance" "window" {
  ami           = local.window_ami
  instance_type = "t3.micro"
  key_name      = "greatstar_key"

  network_interface {
    network_interface_id = aws_network_interface.window.id
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
    Name = "Window"
  }
}

resource "aws_network_interface" "window2" {
  subnet_id       = data.aws_subnet.private[4].id
  private_ips     = ["192.168.5.102"]
  security_groups = [data.aws_security_group.con_linux.id]
  tags = {
    Name = "con_linux_network_interface"
  }
}


resource "aws_instance" "window2" {
  ami           = local.window_ami
  instance_type = "t3.micro"
  key_name      = "greatstar_key"

  network_interface {
    network_interface_id = aws_network_interface.window2.id
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
    Name = "con_linux"
  }
}