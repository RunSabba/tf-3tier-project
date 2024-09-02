terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
    }
  }
}
provider "aws" {
    region = var.region
}

module "remote_backend" {
  source = "/modules/remote_backend"
  username = var.username
  state_bucket = var.state_bucket
  table_name = var.table_name
}