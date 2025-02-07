output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "eks_cluster_arn" {
  value = module.eks.eks_cluster_arn
}


output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
