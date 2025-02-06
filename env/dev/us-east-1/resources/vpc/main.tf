module "vpc" {
  source          = "https://github.com/devops-contribution/shared-modules/modules/vpc?ref=main"
  region          = var.region
  vpc_cidr        = var.vpc_cidr
  vpc_name        = var.vpc_name
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}
