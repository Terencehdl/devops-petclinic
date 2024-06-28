provider "aws" {
  region     = "eu-west-3"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
  petclinic-vpc = module.vpc.vpc
}

module "eks"{
  source = "./modules/eks"
  petclinic-public-subnet-a = module.vpc.petclinic-public-subnet-a
  petclinic-public-subnet-b = module.vpc.petclinic-public-subnet-b
  petclinic-public-subnet-c = module.vpc.petclinic-public-subnet-c
  petclinic-private-subnet-a = module.vpc.petclinic-private-subnet-a
  petclinic-private-subnet-b = module.vpc.petclinic-private-subnet-b
  petclinic-private-subnet-c = module.vpc.petclinic-private-subnet-c
}
