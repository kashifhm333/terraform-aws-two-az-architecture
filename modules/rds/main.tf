resource "aws_db_subnet_group" "main" {
  name = "${var.project_name}-db-subnet-group"

  subnet_ids = var.private_db_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier = "${var.project_name}-db"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = var.db_instance_class

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.database_name
  username = var.database_username
  password = var.database_password

  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [
    var.database_sg_id
  ]

  publicly_accessible = false

  skip_final_snapshot = true

  backup_retention_period = 7

  multi_az = true

  tags = {
    Name = "${var.project_name}-database"
  }
}