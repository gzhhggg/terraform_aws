# 踏み台サーバー
resource "aws_instance" "bastion" {
  ami = local.ami
  instance_type = local.instance_type
  key_name = "aws_test"
  subnet_id     = aws_subnet.public["a"].id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  tags = {
    Name = "bastion-server"
  }
}

resource "aws_eip" "bastion" {
  vpc = true
  instance = aws_instance.bastion.id
  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "protect" {
  for_each = aws_subnet.protect

  ami = local.ami
  instance_type = local.instance_type
  key_name = "aws_test"
  subnet_id     = each.value.id
  vpc_security_group_ids = [aws_security_group.protect.id]
  tags = {
    Name = "protect-server-${each.key}"
  }
}