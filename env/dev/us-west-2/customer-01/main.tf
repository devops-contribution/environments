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
  vpc_cidr               = var.vpc_cidr
  public_subnet_az1_cidr = var.public_subnet_az1_cidr
  public_subnet_az2_cidr = var.public_subnet_az2_cidr
  customer               = "customer-01"
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
  public_key             = var.public_key
  customer               = "customer-01"
}

module "vault" {
  source                 = "git::https://github.com/devops-contribution/shared-modules.git//modules/vault?ref=main"
  vpc_id                 = module.vpc.vpc_id
  subnet_id              = module.vpc.public_subnet_az1_id
  bucket_name            = "custom-vault-data-bucket"
  customer               = "customer-01"
}

module "api_gateway" {
  source                 = "git::https://github.com/devops-contribution/shared-modules.git//modules/api-gateways?ref=main"
  alb_dns                = "http://a46670596b7f142ba8ab2b1b6480d5c3-45954369.us-west-2.elb.amazonaws.com"
  region                 = "us-west-2"

}
