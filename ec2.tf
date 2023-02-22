resource "aws_security_group" "sg_ec2_instance" {
  name   = "sg_ec2_instance_naufal"
  vpc_id = aws_vpc.vpc.id

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

resource "aws_instance" "app_server" {
  ami                    = "ami-0f2eac25772cd4e36"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_ec2_instance.id]
  subnet_id              = aws_subnet.main_subnet.id

  tags = {
    Name = var.instance_name
  }
}