variable "ec2_key_name" {
  description = "this is a variable to manage ec2_key_name"
  type        = string
  default     = "test100"
  //default = "prod"
}

variable "ec2_instance_type" {
  description = "this is a variable to manage ec2_instance_type"
  type        = string
  default     = "t2.micro"
  //default = "prod"
}

variable "ec2_ami" {
  description = "this is a variable to manage ec2_ami type"
  type        = string
  default     = "ami-0a7abae115fc0f825"
}

# variable "baston_id" {
#   description = "this is a variable to manage baston_security_group_id"
#   type        = string
#   // You should provide a default or pass this value explicitly when calling the module
# }

variable "public_subnets_main_id" {
  description = "this is a variable to manage subnet_id in module"
  type        = list(string)
  default     = []
}

variable "private_subnets_id" {
  description = "this is a variable to manage private subnet_id in module"
  type        = list(string)
  default     = []
}

# variable "web_security_group_id" {
#   description = "this is a variable to manage web_security_group_id"
#   type        = string
#   // You should provide a default or pass this value explicitly when calling the module
# }

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public Subnet CIDR values"
  default = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]
}

variable "private_subnet_cidrs" {
  default = [
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]
}
