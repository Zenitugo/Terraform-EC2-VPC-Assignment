output "vpc_id" {
  value = aws_vpc.custom-vpc.id
}

output "vpc_id_id" {
    value = aws_vpc.custom-vpc.id
}

output "private_subnet_id" {
    value =  aws_subnet.private-subnet.id
}

output "public_subnet_id" {
    value =  aws_subnet.public-subnet.id
}