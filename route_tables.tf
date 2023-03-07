# create private route table
resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.main.id
  tags={
    Name="private route table"
  }
}
# associate all private subnets to the private route table
resource "aws_route_table_association" "private-subnets-assoc" {
  count          = length(aws_subnet.private[*].id)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private-rtb.id
}


# create public route table
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name="public route table"
  }
   route {
    cidr_block = var.public_route_table_cidr
    gateway_id = aws_internet_gateway.gw.id
  }
  }
# associate all public subnets to the public route table
resource "aws_route_table_association" "public-subnets-assoc" {
  count          = length(aws_subnet.public[*].id)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public-rtb.id
}


