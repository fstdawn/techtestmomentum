variable "project" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "technical-test"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "multi_az" {
  description = "Specify Multi-AZ"
  type        = bool
  default     = true
}

variable "aws_security_group" {
  description = "A list of security groups"
  type        = list(string)
  default     = ["sg-0acb1063a3cfcb9c8"]
}

variable "aws_subnet_ids" {
  description = "A list of DB subnets"
  type        = list(string)
  default     = ["subnet-09378fecff22bfd03","subnet-0aec7148e708331da"]
}
