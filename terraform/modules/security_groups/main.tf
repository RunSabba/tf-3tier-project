# Security group for EC2 instances
resource "aws_security_group" "runsabba_ec2_sg" {
  name        = "Runsabba-EC2-SG"
  description = "Allow traffic from my VPC"
  vpc_id      = var.aws_vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #best practice would be your company network IP
  }

  ingress {
    description = "Allow ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp" #ts purposes. traceRT,ping etc.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security groups for my EC2's"
  }
}

# Load balancer security group
resource "aws_security_group" "lb_security_group" {
  name        = "Runsabba-ALB-SG"
  vpc_id      = var.aws_vpc_id
  description = "Application load balancer security group"

  ingress {
    description = "Allow all HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = " Allow all HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Application load balancer security group"
  }
}

# Database security group
resource "aws_security_group" "db_security_group" {
  name        = "Runsabba-DB-SG"
  description = "Database Security Group Allow Traffic"
  vpc_id      = var.aws_vpc_id

  ingress {
    description     = "Allow MySQL from EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.runsabba_ec2_sg.id]
  }

  ingress {
    description = "Allow SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.runsabba_ec2_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.public_1_cidr, var.public_2_cidr] #can only send oubound traffic to webserver subnets
  }

  tags = {
    Name = "Database Security Group Allow Traffic"
  }
}