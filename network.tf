resource "aws_subnet" "public" {
  for_each = local.subnet.public

  vpc_id            = aws_vpc.default.id
  cidr_block        = each.value
  availability_zone = "${data.aws_region.current.name}${each.key}"
  tags = {
    "Name" = "public-subnet-${each.key}"
  }
}

resource "aws_subnet" "protect" {
  for_each = local.subnet.protect

  vpc_id            = aws_vpc.default.id
  cidr_block        = each.value
  availability_zone = "${data.aws_region.current.name}${each.key}"
  tags = {
    "Name" = "protect-subnet-${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each = local.subnet.private

  vpc_id            = aws_vpc.default.id
  cidr_block        = each.value
  availability_zone = "${data.aws_region.current.name}${each.key}"
  tags = {
    "Name" = "private-subnet-${each.key}"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "internet-gateway"
  }
}

resource "aws_eip" "default" {
  for_each = local.subnet.public
  vpc      = true
  tags = {
    Name = "public-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "default" {
  for_each = aws_eip.default

  subnet_id     = aws_subnet.public[each.key].id
  allocation_id = each.value.id
  tags = {
    Name = "nat-gateway-${each.key}"
  }
}

###route table

#public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

#protect
resource "aws_route_table" "protect" {
  for_each = aws_subnet.public

  vpc_id = aws_vpc.default.id
  tags = {
    Name = "protect-rt-${each.key}"
  }
}

resource "aws_route_table_association" "protect" {
  for_each = aws_subnet.protect

  subnet_id      = aws_subnet.protect[each.key].id
  route_table_id = aws_route_table.protect[each.key].id
}

resource "aws_route" "nat" {
  for_each               = aws_route_table.protect
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = each.value.id
  nat_gateway_id         = aws_nat_gateway.default[each.key].id
}