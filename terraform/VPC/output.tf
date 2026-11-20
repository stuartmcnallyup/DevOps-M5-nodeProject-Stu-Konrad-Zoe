output "vpc_id" {
  value = aws_vpc.vpc01.id
}

output "route_table_id" {
  value = aws_route_table.public.id
}
