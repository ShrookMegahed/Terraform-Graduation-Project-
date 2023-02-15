/* resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = element(aws_subnet.public.*.id, 0)
  depends_on    = [aws_internet_gateway.gw]

  tags = {
    Name = "nat_gateway"
  }
}

resource "aws_eip" "nat-eip" {
  depends_on = [
    aws_internet_gateway.gw
  ]
  vpc = true
  tags = {
    "name" = "nat-eip"
  }
} */