# main.tf content for eks/
resource "aws_eks_cluster" "petclinic-eks-cluster" {
   name = "petclinic-eks-cluster"
   role_arn = aws_iam_role.eks-cluster-role.arn
   vpc_config {
     subnet_ids = [var.petclinic-private-subnet-a.id, var.petclinic-private-subnet-b.id, var.petclinic-private-subnet-c.id,var.petclinic-public-subnet-a.id, var.petclinic-public-subnet-b.id, var.petclinic-public-subnet-c.id]
   }
  
}

resource "aws_iam_role" "eks-cluster-role" {
  name               = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "EKS Cluster Role"
  }
}

# The two policies allow you to properly access EC2 instances (where the worker nodes run) and EKS.
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-cluster-role.name
}

resource "aws_eks_node_group" "worker-node-groupe-petclinic" {
  cluster_name    = aws_eks_cluster.petclinic-eks-cluster.name
  node_group_name = "workernodes-petclinic"
  node_role_arn   = aws_iam_role.workernodes.arn
  subnet_ids = [var.petclinic-private-subnet-a.id, var.petclinic-private-subnet-b.id, var.petclinic-private-subnet-c.id,var.petclinic-public-subnet-a.id, var.petclinic-public-subnet-b.id, var.petclinic-public-subnet-c.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
#   ]
}

# Create iam role and policies for our workrer nodes
resource "aws_iam_role" "workernodes" {
  name = "eks-node-group-1"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com",

      }

    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.workernodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.workernodes.name
}

resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role       = aws_iam_role.workernodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.workernodes.name
}