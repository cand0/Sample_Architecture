

resource "aws_instance" "architect_ops" {
  ami = local.ami
  instance_type = "t3.micro"
  key_name = "greatstar_key"
  iam_instance_profile = "${aws_iam_instance_profile.architect_policy.name}"
  vpc_security_group_ids = [
    data.aws_security_group.ops_architect.id
  ]
  subnet_id = data.aws_subnet.architect_ops.id

  tags = {
    Name = "architect_ops"
    Environment = "architect"
  }
}
resource "aws_instance" "architect_dev" {
  ami = local.ami
  instance_type = "t3.micro"
  key_name = "greatstar_key"
  iam_instance_profile = "${aws_iam_instance_profile.architect_policy.name}"
  vpc_security_group_ids = [
    data.aws_security_group.dev_architect.id
  ]
  subnet_id = data.aws_subnet.architect_dev.id

  tags = {
    Name = "architect_dev"
    Environment = "architect"
  }
}
