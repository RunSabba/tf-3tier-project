terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = var.region
}

module "remote_backend" {
  source       = "./modules/remote_backend"
  username     = var.username
  state_bucket = var.state_bucket
  table_name   = var.table_name
}


module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  public_subnet_1  = var.public_subnet_1
  public_subnet_2  = var.public_subnet_2
  private_subnet_1 = var.private_subnet_1
  private_subnet_2 = var.private_subnet_2
  az1 = var.az1
  az2 = var.az2
}

module "security_groups" {
  source     = "./modules/security_groups"
  aws_vpc_id = module.vpc.aws_vpc_id
}

module "load_balancer" {
  source               = "./modules/load_balancer"
  lb_security_group_id = module.security_groups.lb_security_group_id
  runsabba_public_1_id = module.vpc.runsabba_public_1_id
  runsabba_public_2_id = module.vpc.runsabba_public_2_id
  aws_vpc_id           = module.vpc.aws_vpc_id
  web_server_1 = module.web_servers.web_server_1
  web_server_2 = module.web_servers.web_server_2
}

module "web_servers" {
  source                = "./modules/web_servers"
  runsabba_public_1_id  = module.vpc.runsabba_public_1_id
  runsabba_public_2_id  = module.vpc.runsabba_public_2_id
  ec2_security_group_id = module.security_groups.ec2_security_group_id
  runsabba_gateway      = module.vpc.runsabba_gateway
  ami                   = var.ami
  instance_type         = var.instance_type
  key_name              = var.key_name
} 

module "database" {
  source = "./modules/database"
  db_security_group_id = module.security_groups.db_security_group_id
  instance_class = var.instance_class
  db_username = var.db_password
  db_password = var.db_password
  engine_version = var.engine_version
  
}