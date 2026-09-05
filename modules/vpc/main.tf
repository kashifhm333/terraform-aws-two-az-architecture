resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = var.vpc_tags
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my_vpc.id
    
    tags = {
        Name = "${var.project_name}-my-igw"
    }
  
}

resource "aws_subnet" "public_subent_A" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_A_cidr
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"

    tags = {
      "Name" = "${var.project_name}-my-public-subnet-A"
    }
}

resource "aws_subnet" "public_subnet_B" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_B_cidr
    map_public_ip_on_launch = true
    availability_zone = "us-east-1b"
    tags = {
      Name = "${var.project_name}-my-public-subnet-B"
    }
  
}


resource "aws_subnet" "private_subnet_A" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnets_cidr[0]
    availability_zone = "us-east-1a"
    tags = {
      Name = "${var.project_name}-my-private-subnet-A"
    }
  
}


resource "aws_subnet" "private_subnet_B" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnets_cidr[1]
    availability_zone = "us-east-1b"
    tags = {
      Name = "${var.project_name}-my-private-subnet-B"
    }
  
}



resource "aws_subnet" "private_subnet_db_A" {
   vpc_id = aws_vpc.my_vpc.id
   cidr_block = var.private_db_cidr[0]
   availability_zone = "us-east-1a"
   tags = {
     Name = "${var.project_name}-my-private-subnet-db-A"}

}


resource "aws_subnet" "private_subnet_db_B" {
   vpc_id = aws_vpc.my_vpc.id
   cidr_block = var.private_db_cidr[1]
   availability_zone = "us-east-1b"
   tags = {
     Name = "${var.project_name}-my-private-subnet-db-B"}

}

resource "aws_eip" "eip_a" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat-A" {
    allocation_id = aws_eip.eip_a.id
    subnet_id = aws_subnet.public_subent_A.id
    depends_on = [ aws_internet_gateway.igw ]
    tags = {
      Name = "${var.project_name}-my-nat-gateway-A"}
}

resource "aws_eip" "eip_b" {
  domain = "vpc"

}

resource "aws_nat_gateway" "nat_b" {
    allocation_id = aws_eip.eip_b.id
    subnet_id = aws_subnet.public_subnet_B.id
    depends_on = [ aws_internet_gateway.igw ]
    tags = {
      Name = "${var.project_name}-my-nat-gateway-B"}
  
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_rt_assoc_A" {
    subnet_id = aws_subnet.public_subent_A.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_assoc_B" {
    subnet_id = aws_subnet.public_subnet_B.id
    route_table_id = aws_route_table.public_rt.id

}

resource "aws_route_table" "private_rt_A" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-A.id
    }
  
}

resource "aws_route_table_association" "private_rt_assoc_A" {
  subnet_id = aws_subnet.private_subnet_A.id
  route_table_id = aws_route_table.private_rt_A.id
}



resource "aws_route_table" "private_rt_B" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_b.id

    }

    tags = {
        Name = "my-private-rt-B"
    }
  
}


resource "aws_route_table_association" "private_rt_assoc_B" {
    subnet_id = aws_subnet.private_subnet_B.id
    route_table_id = aws_route_table.private_rt_B.id
  
}



