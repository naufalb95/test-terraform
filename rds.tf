resource "aws_security_group" "sg_rds_instance" {
  name   = "sg_rds_instance_naufal"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port       = "5432"
    to_port         = "5432"
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_ec2_instance.id]
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-db"
  subnet_ids = [aws_subnet.main_subnet.id, aws_subnet.secondary_subnet.id]

  tags = {
    Name = "RDS subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = var.rds_allocated_storage
  db_name                = var.rds_db_name
  storage_type           = var.rds_storage_type
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  username               = var.rds_username
  password               = var.rds_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.sg_rds_instance.id]
  db_subnet_group_name   = aws_db_subnet_group.default.id
}