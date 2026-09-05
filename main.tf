module "vpc" {
  source = "./modules/vpc"
  project_name = var.project_name
}

module "security_groups" {
    source = "./modules/sg"
    project_name = var.project_name
    vpc_id = module.vpc.vpc_id
  
}


module "alb" {
  source = "./modules/alb"
  project_name = var.project_name
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id = module.security_groups.alb_sg_id
  vpc_id = module.vpc.vpc_id
}



module "rds" {
  source = "./modules/rds"

  project_name = var.project_name

  private_db_subnet_ids = module.vpc.private_subnet_db_id

  database_sg_id = module.security_groups.db_sg_id

  database_name     = "appdb"
  database_username = "admin"
  database_password = var.database_password

  db_instance_class = "db.t3.micro"
}