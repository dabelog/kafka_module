resource "aws_security_group" "kafka-cluster-sg" {
  name        = var.sg_name
  description = "kafka cluster Security Group"
  vpc_id      = aws_vpc.master_vpc.id

  ingress {
    from_port        = 9094
    to_port          = 9094
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 2128
    to_port          = 2128
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
