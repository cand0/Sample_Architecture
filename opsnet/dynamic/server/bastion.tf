resource "aws_instance" "bastion" {
  ami                         = "ami-02727842b84fc892d"
  instance_type               = "t2.micro"
  key_name                    = "greatstar_key"
  iam_instance_profile        = aws_iam_instance_profile.ec2_server.name
  associate_public_ip_address = true
  vpc_security_group_ids = [
    data.aws_security_group.bastion.id
  ]
  subnet_id = data.aws_subnet.public[0].id

  tags = {
    Name        = "ops_bastion"
    Envrionment = "ops"
  }
}

