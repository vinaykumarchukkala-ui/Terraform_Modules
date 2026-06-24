# configure aws provider
provider "aws" {
  region  = var.region
  profile = "terraform-user"
}

# create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# use data source to get all availability zones in region
data "aws_availability_zones" "available_zones" {}

# create all subnets using for_each
resource "aws_subnet" "subnets" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[each.value.az_index]
  map_public_ip_on_launch = each.value.map_public_ip

  tags = {
    Name = "${var.project_name}-${each.key}"
  }
}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# associate public subnets to public route table using for_each
resource "aws_route_table_association" "public_subnets" {
  for_each = {
    for key, subnet in aws_subnet.subnets : key => subnet.id
    if contains(keys({for k, v in var.subnets : k => v if strcontains(k, "public")}), key)
  }

  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.public_route_table.id
}