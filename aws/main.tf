terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region

  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "mirroring" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "rabbitmq-mirroring"
  }
}

resource "aws_subnet" "one" {
  cidr_block        = cidrsubnet(aws_vpc.mirroring.cidr_block, 3, 1)
  vpc_id            = aws_vpc.mirroring.id
  availability_zone = "${var.region}c"

  map_public_ip_on_launch = true
}

resource "aws_security_group" "ingress_all" {
  name   = "allow-all-sg"
  vpc_id = aws_vpc.mirroring.id
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mirroring" {
  ami           = var.ami
  instance_type = var.instanceType

  key_name        = var.ami_key_pair_name
  security_groups = ["${aws_security_group.ingress_all.id}"]
  subnet_id       = aws_subnet.one.id

  tags = {
    Name = "rabbitmq-mirroring"
  }

  user_data = file("scripts/init.sh")

  connection {
    type        = "ssh"
    user        = var.username
    password    = ""
    private_key = file(var.keyPath)
    host        = self.public_ip
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.mirroring.id
  vpc      = true

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.mirroring.id
  tags = {
    Name = "rabbitmq-mirroring"
  }
}

resource "aws_route_table" "routes" {
  vpc_id = aws_vpc.mirroring.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.one.id
  route_table_id = aws_route_table.routes.id
}