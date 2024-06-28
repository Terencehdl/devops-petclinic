# outputs.tf content for vpc/
output "vpc_id" {
  value = aws_vpc.petclinic-vpc.id
}

output "vpc" {
   value = aws_vpc.petclinic-vpc
  
}

output "petclinic-public-subnet-a"{
  value = aws_subnet.petclinic-public-subnet-a
}
output "petclinic-public-subnet-b"{
  value = aws_subnet.petclinic-public-subnet-b
}
output "petclinic-public-subnet-c"{
  value = aws_subnet.petclinic-public-subnet-c
}
output "petclinic-private-subnet-a"{
  value = aws_subnet.petclinic-private-subnet-a
}
output "petclinic-private-subnet-b"{
  value = aws_subnet.petclinic-private-subnet-b
}
output "petclinic-private-subnet-c"{
  value = aws_subnet.petclinic-private-subnet-c
}
