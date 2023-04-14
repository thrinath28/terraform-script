# creating the vpc

resource "aws_vpc" "Demo-vpc" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"
  
  tags = {
    Name = "Demo-vpc"
  }
}

# creating public subnets

resource "aws_subnet" "Mysubnet-1" {
  vpc_id     = aws_vpc.Demo-vpc.id
  cidr_block = "10.10.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch= "true"

  tags = {
    Name = "Mysubnet-1"
  }
}

resource "aws_subnet" "Mysubnet-2" {
  vpc_id     = aws_vpc.Demo-vpc.id
  cidr_block = "10.10.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch= "true"

  tags = {
    Name = "Mysubnet-2"
  }
}

# creating private subnets

resource "aws_subnet" "Mysubnet-3" {
  vpc_id     = aws_vpc.Demo-vpc.id
  cidr_block = "10.10.3.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch= "false"

  tags = {
    Name = "Mysubnet-3"
  }
}

resource "aws_subnet" "Mysubnet-4" {
  vpc_id     = aws_vpc.Demo-vpc.id
  cidr_block = "10.10.4.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch= "false"

  tags = {
    Name = "Mysubnet-4"
  }
}