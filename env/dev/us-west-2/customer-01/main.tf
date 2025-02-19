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

locals {
  customer_name = "Milton"
}

module "vpc" { 
  source                  = "git::https://github.com/devops-contribution/shared-modules.git//modules/vpc?ref=main"
  
  name                    = "${local.customer_name}-vpc"
  cidr                    = "10.0.0.0/16"
  azs                     = data.aws_availability_zones.available.names
  private_subnets         = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets          = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway      = true
  single_nat_gateway      = true
  enable_dns_hostnames    = true
  enable_dns_support      = true
}

module "eks" {
  source                  = "git::https://github.com/devops-contribution/shared-modules.git//modules/eks?ref=main"

  cluster_name            = "${local.customer_name}-cluster"
  cluster_version         = "1.31"
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnets
  cluster_endpoint_public_access  = true  
}

module "vault" {
  source                 = "git::https://github.com/devops-contribution/shared-modules.git//modules/vault?ref=main"

  vpc_id                 = module.vpc.vpc_id
  subnet_id              = module.vpc.public_subnets[0]
  bucket_name            = "custom-vault-data-bucket"
  customer               = "${local.customer_name}"
}
