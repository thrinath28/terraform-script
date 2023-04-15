# create security group for wordpress instance

resource "aws_security_group" "sg_wordpress" {
  name        = "sg_wordpress"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.Demo-vpc.id

  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] 
   
  }

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
     Name = "sg_wordpress"
  }
 }

# create SG for Bastion host

 resource "aws_security_group" "sg_bastion-host" {
  name        = "sg_bastion-host"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.Demo-vpc.id

  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] 
  }

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
     Name = "sg_bastion-host"
  }
 }
 
 # creating SG for Lb

 resource "aws_security_group" "sg_Load-balancer" {
  name        = "sg_Load-balancer"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.Demo-vpc.id

  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_Load-balancer"
  }
}



