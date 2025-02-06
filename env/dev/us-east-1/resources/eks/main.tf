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


data "aws_vpcs" "filtered_vpcs" {
  filter {
    name   = "tag:GithubOrg"
    values = ["devops-contribution"]
  }
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.filtered_vpcs.ids
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}
  

module "eks" {
  source           = "git::https://github.com/devops-contribution/shared-modules.git//modules/eks?ref=main"
  region           = var.region
  cluster_name     = var.cluster_name
  subnet_ids       = data.aws_subnets.public_subnets.ids
}
