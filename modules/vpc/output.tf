output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_ids" {
  value = [
  aws_subnet.public_subent_A.id,
   aws_subnet.public_subnet_B.id
   ]
}



output "private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_A.id,
   aws_subnet.private_subnet_B.id
   ]
}

output "private_subnet_db_id" {
  value = [
    aws_subnet.private_subnet_db_A.id,
   aws_subnet.private_subnet_db_B.id
  ]
}

