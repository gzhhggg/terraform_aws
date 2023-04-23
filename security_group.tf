#セキュリティグループ作成

resource "aws_security_group" "bastion" {
  name   = "ec2-bastion"
  vpc_id = aws_vpc.default.id
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion"
  }
}

resource "aws_security_group" "protect" {
  name        = "security_group_protect"
  description = "Allow bastion inbound traffic"
  vpc_id      = aws_vpc.default.id
  tags = {
    Name = "protect"
  }
}

resource "aws_security_group_rule" "protect_inbound" {
  for_each = toset([
    "80",
    "22",
  ])
  type                     = "ingress"
  from_port                = each.value
  to_port                  = each.value
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id        = aws_security_group.protect.id
}

resource "aws_security_group_rule" "protect_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.protect.id
}

resource "aws_security_group" "private" {
  name        = "security_group_private"
  description = "Allow postgres inbound traffic"
  vpc_id      = aws_vpc.default.id
  tags = {
    Name = "private"
  }
}

resource "aws_security_group_rule" "private_inbound" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.protect.id
  security_group_id        = aws_security_group.private.id
}

resource "aws_security_group_rule" "private_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private.id
}