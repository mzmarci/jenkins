# configured aws provider with proper credentials

# create default vpc if one does not exit
//resource "aws_default_vpc" "default_vpc" {



# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

# create a default subnet in the first az if one does not exit
//resource "aws_subnet" "subnet_1" {
//availability_zone = data.aws_availability_zones.available_zones.names[0]
//}

# create a default subnet in the second az if one does not exit
//resource  "aws_subnet" "subnet_2" {
//availability_zone = data.aws_availability_zones.available_zones.names[1]
//}


# create security group for the database
resource "aws_security_group" "database_security_group" {
  name        = "database security group"
  description = "enable postgres access on port 5432"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    description     = "postgres"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.Ecs_sg.id]
  }

  ingress {
    description = "postgres"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database_security_group"
  }
}


# create the subnet group for the rds instance
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "database_subnet"
  subnet_ids  = aws_subnet.public_subnets[*].id //[var.public_subnets_id[0]] #change to the public subnet id
  description = "subnet for database instance"

  tags = {
    Name = "database_subnets"
  }
}


# create the rds instance
resource "aws_db_instance" "db_instance" {
  engine                 = "postgres"
  engine_version         = "15.3"
  multi_az               = false
  identifier             = "project"
  username               = var.rds_password
  password               = var.rds_password
  instance_class         = "db.t3.micro"
  allocated_storage      = 400
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.id
  vpc_security_group_ids = [aws_security_group.Ecs_sg.id]
  availability_zone      = data.aws_availability_zones.available_zones.names[0]
  db_name                = var.db_name
  publicly_accessible    = true
  skip_final_snapshot    = true
}
