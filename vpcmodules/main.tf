provider "aws" {
  profile = "default"
  region = "eu-west-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.name
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnet_cidr
  public_subnets  = var.public_subnet_cidr

  enable_nat_gateway = true

  public_subnet_tags = {
      Name = "technical-test-public-eu-west-1a"
  }

  tags = {
    Owner       = "terraform"
    Environment = "tech-test"
  }

  vpc_tags = {
    Name = "technical-test-udevasia"
  }
}
