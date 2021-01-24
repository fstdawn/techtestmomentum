variable "cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. We cannot specify the range of IP addresses, or the size of the CIDR block."
  type        = bool
  default     = false
}

variable "vpc_name" {
  description = "A VPC name/identifier"
  type        = string
  default     = "technical-test-vpc"
}


variable "project" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "technical-test"
}


variable "availability_zones" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1b"]
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
