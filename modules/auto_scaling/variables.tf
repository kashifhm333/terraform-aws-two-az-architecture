variable "project_name" {
    description = "The name of the project"
    type        = string
  
}

variable "instance_type" {
  type = string
}

variable "app_sg_id" {
    description = "The security group ID for the application instances"
    type        = string
    
    
}


variable "targate_group_arn" {
  type = string
}


variable "private_app_subnet_ids" {
  type = list(string)
}