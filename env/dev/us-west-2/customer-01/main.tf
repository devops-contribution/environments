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
  source                  = "git::https://github.com/devops-contribution/shared-modules.git//modules/vpc?ref=main"
  vpc_cidr                = var.vpc_cidr
  private_subnet_az1_cidr = var.private_subnet_az1_cidr
  private_subnet_az2_cidr = var.private_subnet_az2_cidr
  public_subnet_nat_cidr  = var.public_subnet_nat_cidr
  customer                = "customer-01"
}

module "iam" {
  source                  = "git::https://github.com/devops-contribution/shared-modules.git//modules/iam?ref=main"
}

module "security_group" {
  source                  = "git::https://github.com/devops-contribution/shared-modules.git//modules/security-group?ref=main"
  vpc_id                  = module.vpc.vpc_id
  vpc_cidr                = var.vpc_cidr
}

module "eks" {
  source                  = "git::https://github.com/devops-contribution/shared-modules.git//modules/eks?ref=main"
  private_subnet_az1_id   = module.vpc.private_subnet_az1_id
  private_subnet_az2_id   = module.vpc.private_subnet_az2_id
  eks_security_group_id   = module.security_group.eks_security_group_id
  master_arn              = module.iam.master_arn
  worker_arn              = module.iam.worker_arn
  instance_size           = var.instance_size
  public_key              = var.public_key
  customer                = "customer-01"
}

#module "vault" {
#  source                 = "git::https://github.com/devops-contribution/shared-modules.git//modules/vault?ref=main"
#  vpc_id                 = module.vpc.vpc_id
#  subnet_id              = module.vpc.public_subnet_az1_id
#  bucket_name            = "custom-vault-data-bucket"
#  customer               = "customer-01"
#}

module "api_gateway" {
  source                     = "git::https://github.com/devops-contribution/shared-modules.git//modules/api-gateways?ref=main"
  #alb_dns                    = "http://internal-a3275bfe036344067b0c72d2bbde29cb-1085928719.us-west-2.elb.amazonaws.com"
  alb_dns                    = "arn:aws:elasticloadbalancing:us-west-2:014337110715:loadbalancer/net/ad7b1558442f0427e90a7bda79d39f70/4e75b2e4c6e06e7e"
  region                     = "us-west-2"
  customer                   = "customer-01"
  vpc_link_security_group_id = module.security_group.vpc_link_sg_id
  subnet_ids                 = [module.vpc.private_subnet_az1_id, module.vpc.private_subnet_az2_id]
}
