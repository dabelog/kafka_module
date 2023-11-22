# Master VPC
resource "aws_vpc" "master_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "kafka-vpc-kafka"
  }
}


#Internet Gateway setup
resource "aws_internet_gateway" "master_igw" {
  vpc_id = aws_vpc.master_vpc.id

  tags = {
    Name = "kafka-vpc-igw"
  }
}


# Availability Zones
data "aws_availability_zones" "azs_east" {
  state    = "available"
}

#Public Subnet 1
resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.master_vpc.id
  cidr_block              = var.subnet_1
  availability_zone       = element(data.aws_availability_zones.azs_east.names, 0)
  map_public_ip_on_launch = true

  tags = {
    Name = "kafka-vpc-subnet-1"
  }
}
#Public Subnet 2
resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.master_vpc.id
  cidr_block              = var.subnet_2 
  availability_zone       = element(data.aws_availability_zones.azs_east.names, 1)
  map_public_ip_on_launch = true

  tags = {
    Name = "kafka-vpc-subnet-2"
  }
}
#Public Subnet 3
resource "aws_subnet" "subnet_3" {
  vpc_id                  = aws_vpc.master_vpc.id
  cidr_block              = var.subnet_3 
  availability_zone       = element(data.aws_availability_zones.azs_east.names, 2)
  map_public_ip_on_launch = true

  tags = {
    Name = "kafka-vpc-subnet-3"
  }
}


#Public Route Table us-east-1
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.master_vpc.id
  tags = {
    Name = "kafka-vpc-public-rt"
  }
}
#Routes with IGW 
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.master_igw.id
  depends_on             = [aws_route_table.public_rt]
}

resource "aws_main_route_table_association" "set-master-default-rt-ass" {
  vpc_id         = aws_vpc.master_vpc.id
  route_table_id = aws_route_table.public_rt.id
}



