#Public subnet

resource "aws_subnet" "main_public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr_block
  availability_zone       = var.public_availability_zone
  map_public_ip_on_launch = var.public_ip_onlaunch

  tags = {
    Name = "${var.name}_public_subnet"
  }
}

#Private Subnet

resource "aws_subnet" "main_private_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_cidr_block
  availability_zone       = var.private_availability_zone
  map_public_ip_on_launch = var.private_ip_onlaunch

  tags = {
    Name = "${var.name}_private_subnet"
  }
}

#Public RT
resource "aws_route_table" "main_public_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}_public_rt"
  }
}

resource "aws_route" "main_public_route" {
  route_table_id         = aws_route_table.main_public_rt.id
  destination_cidr_block = var.destination_cidr
  gateway_id             = aws_internet_gateway.main_igw.id
  depends_on             = [aws_internet_gateway.main_igw]
}


resource "aws_route_table_association" "main_public_rt_association" {
  subnet_id      = aws_subnet.main_public_subnet.id
  route_table_id = aws_route_table.main_public_rt.id
}

#Private RT
resource "aws_route_table" "main_private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}_private_rt"
  }
}

resource "aws_route" "main_private_route" {
  route_table_id         = aws_route_table.main_private_rt.id
  destination_cidr_block = var.destination_cidr
  nat_gateway_id         = aws_nat_gateway.main_nat_gw.id
  depends_on             = [aws_nat_gateway.main_nat_gw]

}


resource "aws_route_table_association" "main_private_rt_association" {
  subnet_id      = aws_subnet.main_private_subnet.id
  route_table_id = aws_route_table.main_private_rt.id
}

