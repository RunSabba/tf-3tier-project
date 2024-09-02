variable "username" {
    description = "User for the project"
}
variable "state_bucket" {
    description = "our tf backend bucket for tf state."
}
variable "table_name" {
    description = "Name of DynamoDB table for state locking"
  
}