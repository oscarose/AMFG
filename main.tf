provider "aws" {
  version = "~> 3.0"
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
}

module "sns" {
  source = "./modules/sns"
}

module "s3" {
  source = "./modules/s3"
}

module "monitoring" {
  source = "./modules/monitoring"
}