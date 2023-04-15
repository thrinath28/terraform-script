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

# create Internet Gateway

resource "aws_internet_gateway" "Demo-IG" {
  vpc_id = aws_vpc.Demo-vpc.id

  tags = {
    Name = "Demo-IG"
  }
}

# create Route Table

resource "aws_route_table" "Demo-Public-RT" {
  vpc_id = aws_vpc.Demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Demo-IG.id
  }

  tags = {
    Name = "Demo-Public-RT"
  }
}

# Route Table Association

resource "aws_route_table_association" "Demo-Public-RT-Association-1" {
  subnet_id      = aws_subnet.Mysubnet-1.id
  route_table_id = aws_route_table.Demo-Public-RT.id
}

resource "aws_route_table_association" "Demo-Public-RT-Association-2" {
  subnet_id      = aws_subnet.Mysubnet-2.id
  route_table_id = aws_route_table.Demo-Public-RT.id
}