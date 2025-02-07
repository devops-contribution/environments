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

module "eks" {
  source           = "git::https://github.com/devops-contribution/shared-modules.git//modules/eks?ref=main"
  region           = var.region
  cluster_name     = var.cluster_name
  subnet_ids       = data.terraform_remote_state.vpc.outputs.public_subnets
}
