resource "aws_instance" "bastion" {
  ami = "ami-02727842b84fc892d"
  instance_type = "t2.micro"
  key_name = "greatstar_key"
  iam_instance_profile = "${data.aws_iam_instance_profile.dev_ec2_server.name}"
  associate_public_ip_address = true
  vpc_security_group_ids = [
    data.aws_security_group.dev_bastion.id
  ]
  subnet_id = data.aws_subnet.dev_public[0].id

  tags = {
    Name = "dev_bastion"
    Environment = "dev"
  }
}
