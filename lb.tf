
resource "aws_lb" "default" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.bastion.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = true
}

resource "aws_lb_listener" "default" {
  load_balancer_arn = aws_lb.default.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }
}

resource "aws_lb_target_group" "default" {
  name        = "lb-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.default.id
}

resource "aws_lb_target_group_attachment" "default" {
  for_each = aws_instance.protect

  target_group_arn = aws_lb_target_group.default.arn
  target_id        = each.value.id
}