locals {
  db_name  = "dbsample"
  db_name2 = "dbsample-2"
}

#tfsec:ignore:aws-rds-encrypt-instance-storage-data
#resource "aws_db_instance" "rds_mysql" {
#  identifier                 = local.db_name
#  allocated_storage          = 5
#  instance_class             = "db.t3.micro"
#  storage_type               = "gp2"
#  engine                     = "mysql"
#  engine_version             = "5.7.41"
#  username                   = "user"
#  password                   = aws_secretsmanager_secret_version.db_pass.secret_string
#  db_name                    = local.db_name
#  db_subnet_group_name       = aws_db_subnet_group.rds_subnet_group.name
#  skip_final_snapshot        = true
#  apply_immediately          = true
#  auto_minor_version_upgrade = false
#  vpc_security_group_ids     = [aws_security_group.mysql_security_group.id]
#  multi_az                   = false
#  availability_zone          = var.az_name
#  backup_retention_period    = 1
#  ca_cert_identifier         = "rds-ca-rsa2048-g1"
#}

#tfsec:ignore:aws-rds-encrypt-instance-storage-data
#resource "aws_db_instance" "rds_mysql2" {
#  identifier        = local.db_name2
#  allocated_storage = 5
#  instance_class    = "db.t3.micro"
#  storage_type      = "gp2"
#  engine            = "mysql"
#  engine_version    = "8.0"
#  username          = "user"
#  password          = aws_secretsmanager_secret_version.db_pass.secret_string
#  #snapshot_identifier        = aws_db_snapshot.rds_mysql_snapshot.id
#  db_name                    = local.db_name
#  db_subnet_group_name       = aws_db_subnet_group.rds_subnet_group.name
#  skip_final_snapshot        = true
#  apply_immediately          = true
#  auto_minor_version_upgrade = false
#  vpc_security_group_ids     = [aws_security_group.mysql_security_group.id]
#  multi_az                   = false
#  availability_zone          = var.az_name
#  deletion_protection        = false
#  ca_cert_identifier         = "rds-ca-rsa2048-g1"
#}

# route53 weighted record sets + roundrobin for CNAME
#resource "aws_route53_record" "rds_mysql" {
#  for_each = {
#    rds1 = aws_db_instance.rds_mysql.address,
#    rds2 = aws_db_instance.rds_mysql2.address,
#  }
#  zone_id = aws_route53_zone.private_rds.zone_id
#  name    = "rds-mysql-rr.${aws_route53_zone.private_rds.name}"
#  type    = "CNAME"
#  ttl     = "10"
#
#  weighted_routing_policy {
#    weight = 100
#  }
#
#  set_identifier = "foo-bar-${each.key}"
#  records        = [each.value]
#}

#resource "aws_db_snapshot" "rds_mysql_snapshot" {
#  db_instance_identifier = aws_db_instance.rds_mysql.id
#  db_snapshot_identifier = "rds-mysql-snapshot"
#}
