resource "aws_instance" "web_server_1" {
    ami = var.ami
    instance_type = var.instance_type
    security_groups = [var.ec2_security_group_id]
    subnet_id = var.runsabba_public_1_id
    key_name = var.key_name

    tags = {
      Name = "Runsabba-Web-Server-1"
    }
#bash script to install updates,install and start ngnix and writes html page and write to the index.html file
  user_data = <<-EOF
#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
echo "<html><body><h1>Hello from RunSabba Web Server 1!</h1></body></html>" | sudo tee /var/www/html/index.html
EOF
}

resource "aws_instance" "web_server_2" {
    ami = var.ami
    instance_type = var.instance_type
    security_groups = [var.ec2_security_group_id]
    subnet_id = var.runsabba_public_2_id
    key_name = var.key_name

    tags = {
      Name = "Runsabba-Web-Server-2"
    }
    
  user_data = <<-EOF
#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
echo "<html><body><h1>Hello from RunSabba Web Server 2!</h1></body></html>" | sudo tee /var/www/html/index.html
EOF
} 