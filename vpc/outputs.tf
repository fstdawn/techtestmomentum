# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.my_vpc.cidr_block
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private.*.cidr_block
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public.*.cidr_block
}
