variable "project_name" {
  type = string
}

variable "private_db_subnet_ids" {
  type = list(string)
}

variable "database_sg_id" {
  type = string
}

variable "database_name" {
  type = string
}

variable "database_username" {
  type = string
}

variable "database_password" {
  type      = string
  sensitive = true
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}