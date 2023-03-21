locals {
  identifier = "aurora-test"
}

data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.key
}

#tfsec:ignore:aws-rds-encrypt-cluster-storage-data
resource "aws_rds_cluster" "aurora-mysql" {
  cluster_identifier        = local.identifier
  allocated_storage         = 5
  db_cluster_instance_class = "db.t3.micro"
  storage_type              = "gp2"
  engine                    = "aurora-mysql"
  engine_mode               = "provisioned"
  engine_version            = "8.0.mysql_aurora.3.03.0"
  master_username           = "user"
  master_password           = aws_secretsmanager_secret_version.db_pass.secret_string
  database_name             = "auroradb"
  db_subnet_group_name      = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot       = true
  apply_immediately         = true
  vpc_security_group_ids    = [aws_security_group.rds_security_group.id]
  availability_zones        = sort([for subnet in data.aws_subnet.private : subnet.availability_zone])

  lifecycle {
    ignore_changes = [
      availability_zones,
    ]
  }
}