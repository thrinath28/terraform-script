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

# creating the Target group for LB

resource "aws_lb_target_group" "Demo-LB-target-group" {
  name     = "Demo-LB-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Demo-vpc.id
}

# creating LB target group Attachment

resource "aws_lb_target_group_attachment" "Demo-LB-target-group-Attachment-1" {
  target_group_arn = aws_lb_target_group.Demo-LB-target-group.arn
  target_id        = aws_instance.wordpress.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "Demo-LB-target-group-Attachment-2" {
  target_group_arn = aws_lb_target_group.Demo-LB-target-group.arn
  target_id        = aws_instance.bastion-host.id
  port             = 80
}

# creating the Load Balancer

resource "aws_lb" "Demo-LB" {
  name               = "Demo-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_Load-balancer.id]
  subnets            = [aws_subnet.Mysubnet-1.id,aws_subnet.Mysubnet-2.id]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}

# creating the listener

resource "aws_lb_listener" "Demo-LB-Listener" {
  load_balancer_arn = aws_lb.Demo-LB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Demo-LB-target-group.arn
  }
}
