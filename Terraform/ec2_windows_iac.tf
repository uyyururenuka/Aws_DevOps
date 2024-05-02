terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region     = "AWS_REGION"
  access_key = "AWS_ACCESS_KEY"
  secret_key = "AWS_SECRET_KEY"
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

#create aws instance
resource "aws_instance" "web" {
   ami = "ami-07ef4004db979fcd4"
   instance_type = "t2.micro"
   subnet_id = aws_subnet.web.id
   associate_public_ip_address = true
   key_name      = aws_key_pair.deployer.key_name

   tags={
        Name="HelloWorld"
   }
   
}

#creating key pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "yout public key"

resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id

  // Allow inbound traffic on port 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow inbound traffic on port 80 (HTTP)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow outbound traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_sg"
  }
}
