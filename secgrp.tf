resource "aws_security_group" "terrapro-bean-elb" {
  name        = "terrapro-sg"
  description = "Security group for ELB Beanstalk"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "terrapro-bastion-sg" {
  name        = "terrapro-bastion-sg"
  description = "Security group for Bastion Host"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [var.MY-IP]
  }
}

resource "aws_security_group" "terrapro-prod-sg" {
  name        = "terrapro-prod-sg"
  description = "Security group for BeanStalk Instances"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [aws_security_group.terrapro-bastion-sg.id]
  }
}
resource "aws_security_group" "backend-sg" {
  name        = "backend-sg"
  description = "Security group RDS, Amazon MQ, Elastic cache"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [aws_security_group.terrapro-prod-sg.id]
  }
}

resource "aws_security_group_rule" "name" {
  type                     = ingress
  from_port                = 0
  protocol                 = "-1"
  to_port                  = 0
  security_group_id        = aws_security_group.backend-sg.id
  source_security_group_id = aws_security_group.backend-sg.id
}