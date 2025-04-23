provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}

# 1. Create vpc
resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "production"
  }
}

# 2. Create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod-vpc.id
}

# 3. create custom route table
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Prod"
  }
}

# 4. create a subnet
resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "prod-subnet"
  }
}

# 5. associate subnet with route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.prod-route-table.id
}

# 6. create security group to allow port 22, 80, 443
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow WEB inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_WEB"
  }
}

# 7. create network interface with an ip in the usbnet that was created in step 4
resource "aws_network_interface" "web_server-nic" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]
}

# 8. assign an elastic IP to the network interface created in step 7
resource "aws_eip" "one" {
  domain = "vpc"
  network_interface         = aws_network_interface.web_server-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.gw]
}

# 9. create ubuntu server and install/enable apache 2
resource "aws_instance" "web-server-instance" {
  ami = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = "website-key-pair"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.web_server-nic.id
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install apache2 -y
              systemctl enable apache2
              systemctl start apache2
              echo "your first website" > /var/www/html/index.html
              EOF

  tags = {
    Name = "web-server"
  }
}