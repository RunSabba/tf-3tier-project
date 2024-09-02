resource "aws_vpc" "runsabba_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "runsabba_public_1" {
    vpc_id = aws_vpc.runsabba_vpc.id
    cidr_block = var.public_subnet_1
    availability_zone = "us-east-1a"
    map_customer_owned_ip_on_launch = true
}

resource "aws_subnet" "runsabba_public_2" {
    vpc_id = aws_vpc.runsabba_vpc.id
    cidr_block = var.public_subnet_2
    availability_zone = "us-east-1b"
    map_customer_owned_ip_on_launch = true 
}

resource "aws_subnet" "runsabba_private_1" {
    vpc_id = aws_vpc.runsabba_vpc.id
    cidr_block = var.private_subnet_1
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
}

resource "aws_subnet" "runsabba_private_2" {
    vpc_id = aws_vpc.runsabba_vpc.id
    cidr_block = var.private_subnet_2
    availability_zone = "us-east-1b"
    map_customer_owned_ip_on_launch = false
  
}