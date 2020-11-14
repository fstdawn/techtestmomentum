variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "technical-test"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "public_subnet_cidr" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "private_subnet_cidr" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

