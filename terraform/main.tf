provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc"
}

module "iam" {
  source = "./iam"
}

module "eks" {
  source = "./eks"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
}

module "ec2" {
  source = "./ec2"
  subnet_id = module.vpc.public_subnets[0]
}
