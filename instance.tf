# creating the instance

resource "aws_instance" "wordpress" {
  ami                    = var.EC2-AMI
  instance_type          = var.EC2-instance-type
  key_name               = var.EC2-key-pair
  subnet_id              = aws_subnet.Mysubnet-1.id
  vpc_security_group_ids = [aws_security_group.sg_wordpress.id]
  user_data              = file("user-data-wordpress.sh")

  tags = {
    Name = "wordpress"
  }
}


resource "aws_instance" "bastion-host" {
  ami                    = var.EC2-AMI
  instance_type          = var.EC2-instance-type
  key_name               = var.EC2-key-pair
  subnet_id              = aws_subnet.Mysubnet-2.id
  vpc_security_group_ids = [aws_security_group.sg_bastion-host.id]
  user_data              = file("user-data.sh")

  tags = {
    Name = "bastion-host"
  }
}


resource "aws_instance" "private-machine" {
  ami                    = var.EC2-AMI
  instance_type          = var.EC2-instance-type
  key_name               = var.EC2-private-key-pair
  subnet_id              = aws_subnet.Mysubnet-3.id
  vpc_security_group_ids = [aws_security_group.sg_bastion-host.id]

  tags = {
    Name = "private-machine"
  }
}



