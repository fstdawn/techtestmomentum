terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = {
    Name = var.vpc_name
    Owner = "terraform"
    Project = var.project
  }
}
// test
resource "aws_internet_gateway" "inet_gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "technical-test-igw"
    Owner = "terraform"
    Project = var.project
  }
}

resource "aws_route_table" "private" {
  count = length(var.private_subnet_cidr)

  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "technical-test-rt-private"
    Owner = "terraform"
    Project = var.project
  }
}

resource "aws_route" "private" {
  count = length(var.private_subnet_cidr)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw[count.index].id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "technical-test-rt-public"
    Owner = "terraform"
    Project = var.project
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.inet_gw.id
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)

  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "technical-test-subnet-private"
    Owner = "terraform"
    Project = var.project
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)

  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "technical-test-subnet-public"
    Owner = "terraform"
    Project = var.project
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidr)
  vpc = true
  tags = {
    Name = "technical-test-nat-eip"
    Owner = "terraform"
    Project = var.project
  }
}

resource "aws_nat_gateway" "nat_gw" {
  depends_on = [aws_internet_gateway.inet_gw]

  count = length(var.public_subnet_cidr)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "technical-test-nat-gw"
    Owner = "terraform"
    Project = var.project
  }
}
