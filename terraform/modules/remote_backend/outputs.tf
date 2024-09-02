output "dynamoDB_table_arn" {
    value = aws_dynamodb_table.state_lock_table.arn
}
output "two_tier_user_arn" {
    value = aws_iam_user.two_tier_user_arn
}    
