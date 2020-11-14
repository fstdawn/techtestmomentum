provider "aws" {
  region = var.region
}
resource "aws_rds_cluster_parameter_group" "default" {
  name        = "rds-cluster-pg"
  family      = "aurora-postgresql9.6"
  description = "RDS default cluster parameter group"
}

resource "aws_db_parameter_group" "default" {
  name   = "rds-pg"
  family = "aurora-postgresql9.6"
}

module "db" {
  depends_on   = [aws_rds_cluster_parameter_group.default,aws_db_parameter_group.default]
  source  = "terraform-aws-modules/rds-aurora/aws"

  name                            = "technical-test-aurora-db-postgres96"

  engine                          = "aurora-postgresql"
  engine_version                  = "9.6.9"

  vpc_id                          = var.vpcid
  subnets                         = var.aws_subnet_ids

  replica_count                   = 1
  allowed_security_groups         = var.aws_security_group
  allowed_cidr_blocks             = ["10.20.0.0/20"]
  instance_type                   = "db.r4.large"
  storage_encrypted               = true
  apply_immediately               = true
  monitoring_interval             = 10

  db_cluster_parameter_group_name         = aws_rds_cluster_parameter_group.default.name
  db_parameter_group_name = aws_db_parameter_group.default.name

  tags                            = {
    Environment = "dev"
    Terraform   = "true"
  }
}
