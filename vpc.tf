resource "aws_vpc" "default" {
  cidr_block       = local.vpc_id
  instance_tenancy = "default"
  tags = {
    Name = local.vpc_name
  }
}