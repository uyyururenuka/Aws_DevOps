
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = "your access key"
  secret_key = "your secret access key"
}

// To Generate Private Key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "your key name" 
}

// Create Key Pair for Connecting EC2 via SSH
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

// Save PEM file locally
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = "${var.key_name}.pem"
}

# Create a security group
resource "aws_security_group" "sg_ec2" {
  name        = "sg_ec2"
  description = "Security group for EC2"

  ingress {
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
}
#create a vpc
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags={
        Name = "main vpc"
    }
  
}
#create a subnet
resource "aws_subnet" "web" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "web"
    }
}
#create a route table
resource "aws_route_table" "test" {
    vpc_id = aws_vpc.main.id
  
}


#create instance
resource "aws_instance" "public_instance" {
  ami                    = "ami-013e83f579886baeb"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key_pair.key_name
  subnet_id = aws_subnet.web.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg_ec2.id]

  tags = {
    Name = "my-linux-server"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
}
