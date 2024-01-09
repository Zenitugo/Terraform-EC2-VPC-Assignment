# CREATE VPC 

resource "aws_vpc" "custom-vpc" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      vpc_name = var.vpc_name
      environment = "$(var.environment)"
    }

}


# CREATE SUBNET FOR EACH REGION
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.custom-vpc.id
  cidr_block = var.public_subnet
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Name = "public-subnet"
  }
}


resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.custom-vpc.id
  cidr_block = var.private_subnet

  tags = {
    Name = "private-subnet"
  }
}



# CREATE INTERNET GATEWAY FOR EACH REGION

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.custom-vpc.id

  tags = {
    Name = "igw-west"
  }
}


# CREATE ROUTE TABLE FOR EACH REGION
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.custom-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rt-west"
  }
}

# Create ROUTE TABLE ASSOCIATIONS - CONNECT THE PUBLIC SUBNET TO THE ROUTE TABLE
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.rt.id
}


