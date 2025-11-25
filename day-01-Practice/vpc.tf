resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.dns_support
  enable_dns_hostnames = var.dns_hostnames

  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}_igw"
  }
}

resource "aws_eip" "main_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.name}_nat_eip"
  }
}

resource "aws_nat_gateway" "main_nat_gw" {
  allocation_id = aws_eip.main_nat_eip.id
  subnet_id     = aws_subnet.main_public_subnet.id
  depends_on    = [aws_internet_gateway.main_igw]

  tags = {
    Name = "${var.name}_nat_gw"
  }
}
