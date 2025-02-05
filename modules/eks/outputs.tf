output "eks_cluster_id" {
  description = "EKS Cluster ID"
  value       = aws_eks_cluster.eks.id
}

