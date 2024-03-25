resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main_vpc"
  }
}
//use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

//public subnet
resource "aws_subnet" "public_subnets_main" {
  count      = length(var.public_subnet_cidrs)
  //count             = length(split(",", var.public_subnet_cidrs))
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  //cidr_block        = element(split(",", var.public_subnet_cidrs), count.index)
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet Main ${count.index + 1}"
  }

}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main igw"
  }
}

resource "aws_route_table" "route_main" {
  vpc_id = aws_vpc.main_vpc.id


  tags = {
    Name = "RouteTable Main"
  }
}

resource "aws_route_table" "route_main1" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "RouteTable Main2"
  }

}

resource "aws_route_table_association" "public_route" {
  count          = length(aws_subnet.public_subnets_main[*].id)
  subnet_id      = element(aws_subnet.public_subnets_main[*].id, count.index)
  route_table_id = count.index % 2 == 0 ? aws_route_table.route_main.id : aws_route_table.route_main1.id
}

resource "aws_route_table_association" "Private_route" {
  count          = length(aws_subnet.private_subnets_main[*].id)
  subnet_id      = element(aws_subnet.private_subnets_main[*].id, count.index)
  route_table_id = count.index % 2 == 0 ? aws_route_table.Private_main.id : aws_route_table.Private_main1.id
}



# resource "aws_route_table_association" "public_route" {
#   count          = length(aws_subnet.public_subnets[*].id)
#   subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
#   route_table_id = aws_route_table.route_3.id
#   //route_table_id = count.index % 2 == 0 ? aws_route_table.route_3.id : aws_route_table.route_4.id
# }

# resource "aws_route_table_association" "public_route_2" {
#   count          = length(aws_subnet.public_subnets[*].id)
#   subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
#   route_table_id = aws_route_table.route_4.id
#   //route_table_id = count.index % 2 == 0 ? aws_route_table.Private3.id : aws_route_table.Private4.id
# }

resource "aws_route" "route_7" {
  route_table_id         = aws_route_table.route_main.id
  gateway_id             = aws_internet_gateway.main_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "route_9" {
  route_table_id         = aws_route_table.route_main1.id
  gateway_id             = aws_internet_gateway.main_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# create private subnet
resource "aws_subnet" "private_subnets_main" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = element(var.private_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "PrivateSubnet Main -${count.index + 1}"
  }
}

# create route table for private subnet
resource "aws_route_table" "Private_main" {
  vpc_id = aws_vpc.main_vpc.id


  tags = {
    Name = "Private Main RouteTable1"
  }
}

resource "aws_route_table" "Private_main1" {
  vpc_id = aws_vpc.main_vpc.id


  tags = {
    Name = "Private Main RouteTable2"
  }
}

# resource "aws_route_table_association" "Private_1" {
#   count          = length(aws_subnet.private_subnets[*].id)
#   subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
#   route_table_id = aws_route_table.Private3.id
# }

# resource "aws_route_table_association" "Private_route2" {
#   count          = length(aws_subnet.private_subnets[*].id)
#   subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
#   route_table_id = aws_route_table.Private4.id
# }

#create natgateway with eip
resource "aws_eip" "nat" {
  count = length(var.private_subnet_cidrs)
  domain = "vpc" 
  tags = {
    Name = "PrivateEip"
  }
}

resource "aws_nat_gateway" "Nat1" {
  count         = length(var.private_subnet_cidrs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = element(aws_subnet.private_subnets_main[*].id, count.index)
  tags = {
    Name = "PrivateNat"
  }

}