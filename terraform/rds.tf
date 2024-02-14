resource "aws_db_instance" "postgres-dev" {
  allocated_storage = 20 # Minimum as far as I can tell ()

  identifier     = var.rds_instance_identifier
  db_name        = "craft_beer_db"
  engine         = "postgres"
  engine_version = var.postgres_version # Latest version of PostgreSQL available on AWS RDS (as of 2024-02-06)
  instance_class = "db.t3.micro"
  username       = var.username
  password       = var.password
  #   parameter_group_name = "default.mysql5.7"  #TODO: Investigate if this is necessary
  skip_final_snapshot = true
  publicly_accessible = true
  port                = local.db_port
  #   storage_type         = "standard" # Default is SSD (gp2) which is a minimum of 20 GB storage, standard == HDD and 5GB minimum

  # Networking
  vpc_security_group_ids = [aws_security_group.craft_beer_rds_sg.id]
  # db_subnet_group_name   = aws_db_subnet_group.craft_beer_subnet_group.name
  db_subnet_group_name = module.vpc.database_subnet_group_name

  parameter_group_name = aws_db_parameter_group.craft_beer_pg_parameter_group.name
}


resource "aws_db_parameter_group" "craft_beer_pg_parameter_group" {
  name   = "rds-pg"
  family = "postgres16"

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }
}
