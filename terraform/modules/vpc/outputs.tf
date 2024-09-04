output "aws_vpc_id" {
    value = aws_vpc.runsabba_vpc.id
}
output "runsabba_public_1_id" {
    value = aws_subnet.runsabba_public_1.id
}

output "runsabba_public_2_id" {
    value = aws_subnet.runsabba_public_2.id  
}

output "runsabba_private_1_id" {
    value = aws_subnet.runsabba_private_1.id
}

output "runsabba_private_2_id" {
    value = aws_subnet.runsabba_private_2.id
}

output "runsabba_gateway" {
    value = aws_internet_gateway.runsabba_gateway.id  
}

output "runsabba_route_table" {
    value = aws_route_table.runsabba_route_table.id
  
}

