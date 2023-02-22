provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available_zone" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "vpc_naufal"
  }
}

resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.main_subnet_cidr_block
  availability_zone = data.aws_availability_zones.available_zone.names[0]

  tags = {
    Name = "aws_main_subnet"
  }
}

resource "aws_subnet" "secondary_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.secondary_subnet_cidr_block
  availability_zone = data.aws_availability_zones.available_zone.names[1]

  tags = {
    Name = "aws_secondary_subnet"
  }
}