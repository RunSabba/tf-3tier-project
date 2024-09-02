terraform {
  backend "s3" {
    bucket = var.state_bucket
    key = "backend/tf-2tier-tfstate"
    region = "us-east-1"
    dynamodb_table = var.table_name
    encrypt = true    
  }
} 