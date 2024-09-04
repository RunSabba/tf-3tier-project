resource "aws_vpc" "runsabba_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Runsabba-VPC"
  }
}

resource "aws_subnet" "runsabba_public_1" {
    vpc_id = aws_vpc.runsabba_vpc.id
    cidr_block = var.public_subnet_1
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
      Name = "Runsabba-Public-1"
    }
}

resource "aws_subnet" "runsabba_public_2" {
    vpc_id = aws_vpc.runsabba_vpc.id
    cidr_block = var.public_subnet_2
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true

    tags = {
      Name = "Runsabba-Public-2"
    }
}

resource "aws_subnet" "runsabba_private_1" {
    vpc_id = aws_vpc.runsabba_vpc.id
    cidr_block = var.private_subnet_1
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false

    tags = {
      Name = "Runsabba-Private-1"
    }
}

resource "aws_subnet" "runsabba_private_2" {
    vpc_id = aws_vpc.runsabba_vpc.id
    cidr_block = var.private_subnet_2
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false

    tags = {
      Name = "Runsabba-Private-2"
    }
}

resource "aws_internet_gateway" "runsabba_gateway" {
    vpc_id = aws_vpc.runsabba_vpc.id
    
    tags = {
      Name = "Runsabba-IGW"
    }
}

resource "aws_route_table" "runsabba_route_table" {
    vpc_id = aws_vpc.runsabba_vpc.id
    
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.runsabba_gateway.id
    }
    tags = {
      Name = "Runsabba-RT"
    }
}

resource "aws_route_table_association" "rt_association_1" {
    subnet_id = aws_subnet.runsabba_public_1.id
    route_table_id = aws_route_table.runsabba_route_table.id
}

resource "aws_route_table_association" "rt_association_2" {
    subnet_id = aws_subnet.runsabba_public_2.id
    route_table_id = aws_route_table.runsabba_route_table.id
  
}

resource "aws_db_subnet_group" "database_group" {
  name = "database-subnet-group"
  subnet_ids = [aws_subnet.runsabba_private_1.id, aws_subnet.runsabba_private_2.id]
}

