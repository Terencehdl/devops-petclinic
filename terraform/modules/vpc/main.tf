# main.tf content for vpc/
resource "aws_vpc" "petclinic-vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "petclinic-vpc",
  }
}

resource "aws_subnet" "petclinic-public-subnet-a" {
  vpc_id     = aws_vpc.petclinic-vpc.id
  cidr_block = var.cidr_block_public_subnet_a
  availability_zone = "eu-west-3a"

  tags = {
    Name = "petclinic-public-subnet-a"
  }
   depends_on = [ aws_vpc.petclinic-vpc ]
}

resource "aws_subnet" "petclinic-public-subnet-b" {
  vpc_id     = aws_vpc.petclinic-vpc.id
  cidr_block = var.cidr_block_public_subnet_b
  availability_zone = "eu-west-3b"


  tags = {
    Name = "petclinic-public-subnet-b"
  }
   depends_on = [ aws_vpc.petclinic-vpc ]
}

resource "aws_subnet" "petclinic-public-subnet-c" {
  vpc_id     = aws_vpc.petclinic-vpc.id
  cidr_block = var.cidr_block_public_subnet_c
  availability_zone = "eu-west-3c"


  tags = {
    Name = "petclinic-public-subnet-c"
  }
   depends_on = [ aws_vpc.petclinic-vpc ]
}

resource "aws_internet_gateway" "petclinic-internet-gateway" {
  vpc_id = aws_vpc.petclinic-vpc.id

  tags = {
    Name = "petclinic-internet-gateway"
  }
}

resource "aws_route_table" "petclinic-public-route-table" {
  vpc_id = aws_vpc.petclinic-vpc.id

  tags={
   Name = "petclinic-public-route-table"
  }
}

resource "aws_route" "route-igw"{
   route_table_id = aws_route_table.petclinic-public-route-table.id
   destination_cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.petclinic-internet-gateway.id
}

resource "aws_route_table_association" "petclinic-public-subnet-a" {
  subnet_id      = aws_subnet.petclinic-public-subnet-a.id
  route_table_id = aws_route_table.petclinic-public-route-table.id
}

resource "aws_route_table_association" "petclinic-public-subnet-b" {
  subnet_id      = aws_subnet.petclinic-public-subnet-b.id
  route_table_id = aws_route_table.petclinic-public-route-table.id
}

resource "aws_route_table_association" "petclinic-public-subnet-c" {
  subnet_id      = aws_subnet.petclinic-public-subnet-c.id
  route_table_id = aws_route_table.petclinic-public-route-table.id
}


// Private subnet
resource "aws_subnet" "petclinic-private-subnet-a" {
  vpc_id     = aws_vpc.petclinic-vpc.id
  cidr_block = var.cidr_block_private_subnet_a
  availability_zone = "eu-west-3a"

  tags = {
    Name = "petclinic-private-subnet-a"
  }
   depends_on = [ aws_vpc.petclinic-vpc ]
}

resource "aws_subnet" "petclinic-private-subnet-b" {
  vpc_id     = aws_vpc.petclinic-vpc.id
  cidr_block = var.cidr_block_private_subnet_b
  availability_zone = "eu-west-3b"


  tags = {
    Name = "petclinic-private-subnet-b"
  }
   depends_on = [ aws_vpc.petclinic-vpc ]
}

resource "aws_subnet" "petclinic-private-subnet-c" {
  vpc_id     = aws_vpc.petclinic-vpc.id
  cidr_block = var.cidr_block_private_subnet_c
  availability_zone = "eu-west-3c"


  tags = {
    Name = "petclinic-private-subnet-c"
  }
   depends_on = [ aws_vpc.petclinic-vpc ]
}

// NAT GATEWAY FOR PRIVATE SUBNETS

resource "aws_eip" "nat_eip" {
   vpc = true

   tags = {
     Name = "Petclinic-nat-eip",
   }
   depends_on = [ aws_vpc.petclinic-vpc ]
}

resource "aws_nat_gateway" "petclinic-nat-gateway" {
   subnet_id = aws_subnet.petclinic-private-subnet-a.id
   allocation_id = aws_eip.nat_eip.id

   tags = {
     Name = "petclinic-nat-gateway"
   }
   depends_on = [ aws_eip.nat_eip,aws_vpc.petclinic-vpc ]
}

resource "aws_route_table" "petclinic-private-route-table" {
  vpc_id = aws_vpc.petclinic-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.petclinic-nat-gateway.id
  }

  tags = {
    Name = "petclinic-private-route-table"
  }
}

resource "aws_route_table_association" "petclinic-private-subnet-a" {
  subnet_id      = aws_subnet.petclinic-private-subnet-a.id
  route_table_id = aws_route_table.petclinic-private-route-table.id
}

resource "aws_route_table_association" "petclinic-private-subnet-b" {
  subnet_id      = aws_subnet.petclinic-private-subnet-b.id
  route_table_id = aws_route_table.petclinic-private-route-table.id
}

resource "aws_route_table_association" "petclinic-private-subnet-c" {
  subnet_id      = aws_subnet.petclinic-private-subnet-c.id
  route_table_id = aws_route_table.petclinic-private-route-table.id
}

