output "lb_security_group" {
  value = aws_security_group.lb_security_group.id
}

output "baston_security_group" {
  value = aws_security_group.baston_security_group.id
}

output "web_security_group" {
  value = aws_security_group.web_security_group.id
}

# output "Ecs_sg" {
#   value = aws_security_group.Ecs_sg.id
# }

output "public_subnets_id" {
  value = aws_subnet.public_subnets_main[*].id
}

output "private_subnets_id" {
  value = aws_subnet.private_subnets_main[*].id
}

output "test_vpc_id" {
  value = aws_vpc.main_vpc.id
}

