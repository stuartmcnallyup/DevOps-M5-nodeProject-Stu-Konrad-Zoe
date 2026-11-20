resource "aws_subnet" "public" {
  vpc_id                  = var.vpc_id 
  cidr_block              = var.cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = var.route_table_id
}
