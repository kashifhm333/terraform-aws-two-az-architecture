variable "project_name" {
    description = "The name of the project"
    type        = string
  
}

variable "public_subnet_ids" {
    description = "List of public subnet IDs for the ALB"
    type        = list(string)
}

variable "alb_sg_id" {
  description = "The ID of the ALB security group"
  type = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type = string
}