# outputs.tf content for eks/
output "eks" {
  value = aws_eks_cluster.petclinic-eks-cluster
}
