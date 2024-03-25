resource "aws_security_group" "lb_security_group" {
  name        = "lb_security_group"
  description = "Allow SSH and HTTP Connection"
  vpc_id      = aws_vpc.main_vpc.id
  tags = {
    Name = "test"
  }
}

resource "aws_security_group_rule" "lb-igress-rule" {
  security_group_id        = aws_security_group.lb_security_group.id
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_security_group.id
}

resource "aws_security_group_rule" "lb-igress-rule1" {
  security_group_id        = aws_security_group.lb_security_group.id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_security_group.id

}

resource "aws_security_group_rule" "lb-egress-rule" {
  security_group_id = aws_security_group.lb_security_group.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]

}


locals {
  ports = ["22"]
}
//security group for the baston host

resource "aws_security_group" "baston_security_group" {
  name        = "baston_security_group"
  description = "Allow SSH and HTTP Connection"
  vpc_id      = aws_vpc.main_vpc.id


  dynamic "ingress" {
    for_each = local.ports //["20",]
    content {
      description = "allow port for different sources"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "Baston"
  }
}


//security group for the web server

resource "aws_security_group" "web_security_group" {
  name        = "web_security_group"
  description = "Allow SSH and HTTP Connection"
  vpc_id      = aws_vpc.main_vpc.id

  tags = {
    Name = "Web"
  }
}
// source_security_group_id =   aws_security_group.baston.id
resource "aws_security_group_rule" "web-igress-rule" {
  security_group_id        = aws_security_group.web_security_group.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.baston_security_group.id
}

resource "aws_security_group_rule" "web-egress-rule" {
  security_group_id = aws_security_group.web_security_group.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]

}

//security group for ecs cluster and jenkins server


# resource "aws_security_group" "Ecs_sg" {
#   name        = "ecs_security_group"
#   description = "Allow SSH and HTTP Connection"
#   vpc_id      = aws_vpc.main_vpc.id

#   tags = {
#     Name = "Ecs_sg"
#   }
# }

# resource "aws_security_group_rule" "Ecs_sg-igress-rule" {
#   security_group_id = aws_security_group.Ecs_sg.id
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "Ecs_sg-igress-rule3" {
#   security_group_id = aws_security_group.Ecs_sg.id
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "Ecs_sg-igress-rule2" {
#   security_group_id = aws_security_group.Ecs_sg.id
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "Ecs_sg-igress-rule1" {
#   security_group_id = aws_security_group.Ecs_sg.id
#   type              = "ingress"
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "Ecs_sg-egress-rule" {
#   security_group_id = aws_security_group.Ecs_sg.id
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]

# }  