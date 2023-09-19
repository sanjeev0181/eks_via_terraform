# Ec2 instance creating
#resource is Reserved keyword
#aws_instance is Resource provided by terraform provider
#web is user-provided arbitrary resource name 
#ami,instance_type,key_pair is Resource config argument

resource "aws_instance" "web" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name = "terraform"
  # Attach the security group to the instance
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id     = aws_vpc.main.id
  user_data =  "${file("nginx.sh")}"
  
  tags = {
    Name = "test-HelloWorld"
  }
}

# Create Security Group

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  #vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  ingress {
    description      = "TLS from VPC"
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
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}