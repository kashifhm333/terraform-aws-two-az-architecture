variable "project_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}


variable "vpc_tags" {
    type = map(string)
    default = {
        Name = "my-vpc"
    }
  
}


variable "public_subnet_A_cidr" {
  type = string
  default = "10.0.1.0/24"
}
variable "public_subnet_B_cidr" {
  type = string
  default = "10.0.2.0/24"
}


variable "private_subnets_cidr" {
    type = list(string)
    default = [ "10.0.3.0/24" , "10.0.4.0/24" ]
  
}


variable "private_db_cidr" {
  type = list(string)
  default = [ "10.0.5.0/24", "10.0.6.0/24" ]
}