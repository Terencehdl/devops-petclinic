# outputs.tf content for vpc/
output "vpc_id" {
  value = aws_vpc.petclinic-vpc.id
}

output "vpc" {
   value = aws_vpc.petclinic-vpc
  
}
