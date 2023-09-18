#1.Create VPC
#2.
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Terraform-vpc"
  }
}

# Create subnet
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Terraform_public_subnets"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private_subnets"
  }
}

# internet_gateway
#Attach Internet gateway to vpc.

resource "aws_internet_gateway" "automated-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "automated-igw"
  }
}

#Elastic ip

resource "aws_eip" "auto_elb" {

}


# Nat Gateway

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.auto_elb.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "Terraform_gw_nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.automated-igw]
}

# Route Tables


resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.automated-igw.id
  }

  

  tags = {
    Name = "terraform_public-rt"
  }
}

resource "aws_route_table" "private-rt" { 
    vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

   tags = {
    Name = "private-route-table"
  } 
}


#route table association terraform
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private-rt.id
}