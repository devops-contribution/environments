output "eks_cluster_arn" {
  value = module.eks.arn
}

output "cluster_id" {
  value = module.eks.id
}

output "cluster_endpoint" {
  value = module.eks.endpoint
}
