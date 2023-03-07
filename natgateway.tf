# resource "aws_nat_gateway" "nat" {
#   count = var.preferred_number_of_nat
#    allocation_id = aws_eip.nat-eip[count.index].id
#    subnet_id     = element(aws_subnet.public.*.id, count.index)

#   tags = {
#      "Name" = format("nat-%d",count.index)
#    }
#   depends_on = [aws_internet_gateway.gw]
#  }


# resource "aws_eip" "nat-eip" {
#   depends_on = [
#     aws_internet_gateway.gw
#   ]
#   vpc = true
#   tags = {
#     "name" = format("nat-eip-%d",count.index)
#   }
# }
