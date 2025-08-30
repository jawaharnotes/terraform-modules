provider "aws" {
  region = var.region
  profile = "terraform-admin"
}

module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  env             = var.env
}

module "ec2" {
  source            = "./modules/ec2"
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.vpc.sg_id]
  instance_type     = var.instance_type
  env               = var.env
}
