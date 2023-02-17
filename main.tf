terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = "~> 1.3.0"
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-test-naufal"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "subnet-test-naufal"
  }
}

resource "aws_subnet" "main2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "subnet-test-naufal"
  }
}

resource "aws_security_group" "sg_ec2_instance" {
  name   = "sg_ec2_instance_naufal"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_rds_instance" {
  name   = "sg_rds_instance_naufal"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = "5432"
    to_port         = "5432"
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_ec2_instance.id]
  }
}

resource "aws_instance" "app_server" {
  ami                    = "ami-0f2eac25772cd4e36"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_ec2_instance.id]
  subnet_id              = aws_subnet.main.id

  tags = {
    Name = var.instance_name
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "test-subnet-db"
  subnet_ids = [aws_subnet.main.id, aws_subnet.main2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_name                = "testpostgresrds"
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "14.5"
  instance_class         = "db.t3.micro"
  username               = "postgres"
  password               = "postgres"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.sg_rds_instance.id]
  db_subnet_group_name   = aws_db_subnet_group.default.id
}