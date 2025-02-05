module "eks" {
  source       = "../../../../../../modules/eks"
  cluster_name = "dev-eks-cluster"
  subnet_ids   = module.vpc.private_subnet_ids
}

output "eks_cluster_id" {
  value = module.eks.eks_cluster_id
}

