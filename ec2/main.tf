resource "aws_instance" "bastion" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.public_subnets_main[0].id
  vpc_security_group_ids = [aws_security_group.baston_security_group.id]
  key_name               = var.ec2_key_name

     tags = {
    Name = "baston_server"
  }
}

resource "aws_instance" "web_server" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.private_subnets_main[0].id
  vpc_security_group_ids = [aws_security_group.web_security_group.id]
  key_name               = var.ec2_key_name

     tags = {
    Name = "Web_server"
  }
}