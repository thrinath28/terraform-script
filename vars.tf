# varables

variable REGION {
  type    = string
  default = "ap-south-1"
}

variable EC2-AMI {
   type    = string
   default = "ami-02eb7a4783e7e9317"
  
}

variable EC2-instance-type {
   type    = string
   default = "t2.micro"
}

variable EC2-key-pair {
   type    = string
   default = "linux-os-key"
}
