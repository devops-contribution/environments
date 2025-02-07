provider "aws" {
  region = var.region

  # Setting tags at broader level
  default_tags {
    tags = {
      GithubRepo       = "https://github.com/devops-contribution/environments.git"
      GithubOrg        = "devops-contribution"
      Enviroment       = "dev"
      Created-using    = "terraform"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = {
    bucket = var.bucket_name
    key    = "vpc/terraform.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config  = {
    bucket = var.bucket_name
    key    = "eks/terraform.tfstate"
    region = var.region
  }
}

module "node-group" {
  source           = "git::https://github.com/devops-contribution/shared-modules.git//modules/node-group?ref=main"
  cluster_name     = data.terraform_remote_state.eks.outputs.eks_cluster_name
  subnet_ids       = data.terraform_remote_state.vpc.outputs.public_subnets
  node_group_name  = var.node_group_name
  instance_types   = var.instance_types
  desired_size     = var.desired_size
  max_size         = var.max_size
  min_size         = var.min_size
}
