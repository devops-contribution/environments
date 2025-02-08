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

module "vpc" { 
  source                 = "git::https://github.com/devops-contribution/shared-modules.git//modules/vpc?ref=main"
  project_name           = var.project_name    
  vpc_cidr               = var.vpc_cidr
  public_subnet_az1_cidr = var.public_subnet_az1_cidr
  public_subnet_az2_cidr = var.public_subnet_az2_cidr
}

module "iam" {
  source                 = "git::https://github.com/devops-contribution/shared-modules.git//modules/iam?ref=main"
}

module "security_group" {
  source                 = "git::https://github.com/devops-contribution/shared-modules.git//modules/security-group?ref=main"
  vpc_id                 = module.vpc.vpc_id
  ssh_access             = var.ssh_access
  http_access            = var.http_access
}

module "eks" {
  source                 = "git::https://github.com/devops-contribution/shared-modules.git//modules/eks?ref=main"
  public_subnet_az1_id   = module.vpc.public_subnet_az1_id
  public_subnet_az2_id   = module.vpc.public_subnet_az2_id
  eks_security_group_id  = module.security_group.eks_security_group_id
  master_arn             = module.iam.master_arn
  worker_arn             = module.iam.worker_arn
  instance_size          = var.instance_size
}
