output "lb_security_group" {
  value = aws_security_group.lb_security_group.id
}

output "baston_security_group" {
  value = aws_security_group.baston_security_group.id
}

output "web_security_group" {
  value = aws_security_group_rule.web-igress-rule.id
}

output "Ecs_sg" {
  value = aws_security_group.Ecs_sg.id
}

output "public_subnets_id" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnets_id" {
  value = aws_subnet.private_subnets[*].id
}

output "test_vpc_id" {
  value = aws_vpc.test_vpc.id
}

output "jenkins_server_ip" {
  value = aws_instance.jenkins_server.public_ip
}