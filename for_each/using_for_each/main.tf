# configure aws provider
provider "aws" {
  region    = var.region
  profile   = "terraform-user"
}

# create vpc
module "vpc" {
  source       = "../modules/vpc"
  region       = var.region
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  subnets      = var.subnets
}