resource "aws_db_subnet_group" "terra-rds-subgrp" {
  name       = "main"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Subnet for RDS"
  }
}

resource "aws_elasticache_subnet_group" "terrpro-ecache-subgrp" {
  name       = "ecache-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "subnet group for ecache"
  }
}

resource "aws_db_instance" "terrapro-rds" {
  allocated_storage      = 20
  storage_type           = gp2
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  username               = var.dbname
  password               = var.dbpass
  parameter_group_name   = "default.mysql5.7"
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.terra-rds-subgrp.name
  vpc_security_group_ids = [aws_security_group.backend-sg.id]
}

resource "aws_elasticache_cluster" "terrapro-cache" {
  cluster_id           = "terrapro-cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.4"
  port                 = 11211
  subnet_group_name = [aws_elasticache_subnet_group.terrpro-ecache-subgrp.id]
  security_group_ids = [module.vpc.aws_security_group.aws_security_group.backend-sg.id]
}

resource "aws_mq_broker" "terrra-mq" {
  broker_name = "terra-mq"

  configuration {
    id       = aws_mq_configuration.test.id
    revision = aws_mq_configuration.test.latest_revision
  }

  engine_type        = "ActiveMQ"
  engine_version     = "5.15.9"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.backend-sg.id]
  subnet_ids = [module.vpc.private_subnets[0]]

  user {
    username = var.rmquser
    password = var.rmqpass
  }
}