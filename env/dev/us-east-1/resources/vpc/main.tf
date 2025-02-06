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

#module "vpc" {
#  source          = "git::https://github.com/devops-contribution/shared-modules.git//modules/vpc?ref=main"
#  region          = var.region
#  vpc_cidr        = var.vpc_cidr
#  vpc_name        = var.vpc_name
#  public_subnets  = var.public_subnets
#  private_subnets = var.private_subnets
#  azs             = var.azs
#}
