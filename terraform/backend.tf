terraform {
  backend "s3" {
    bucket         = "2tier-state-bucket-runsabba"
    key            = "backend/tf-2tier-tfstate"
    region         = "us-east-1"
    dynamodb_table = "2tier-state-lock-table"
    encrypt        = true
  }
} 