resource "aws_instance" "jenkins_server" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.public_subnets[0].id //length(var.public_subnets_id) > 0 ? var.public_subnets_id[0] : null //var.public_subnets_id[0]
  vpc_security_group_ids = [aws_security_group.Ecs_sg.id]
  key_name               = var.ec2_key_name
  user_data              = file("user_data.sh")

  tags = {
    Name = "jenkins_server"
  }
}



