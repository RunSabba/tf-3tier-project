#creating a user for the project
resource "aws_iam_user" "two_tier_user" {
    name = var.username
}
#attaching admin access policy to the user
resource "aws_iam_user_policy_attachment" "admin_policy_attachment" {
   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
   user = aws_iam_user.two_tier_user.id
}

#creating s3 bucket to store the tf state/backend
resource "aws_s3_bucket" "tf-state-bucket" {
    bucket = var.state_bucket

#lifecycle block to prevent deletion
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = var.state_bucket
  }
}
#enabling versioning on the bucket to prevent losing our state incase of deletion
resource "aws_s3_bucket_versioning" "state_versioning" {
    bucket = aws_s3_bucket.tf-state-bucket.id

    versioning_configuration {
      status = "Enabled"
    }
  
}

resource "aws_s3_bucket_policy" "state_bucket_policy" {
  bucket = aws_s3_bucket.tf-state-bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:ListBucket",
        Resource = aws_s3_bucket.tf-state-bucket.arn,
        Principal = {
          AWS = aws_iam_user.two_tier_user.arn
        }
      },
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject", "s3:PutObject"],
        Resource = "${aws_s3_bucket.tf-state-bucket.arn}/*",
        Principal = {
          AWS = aws_iam_user.two_tier_user.arn
        }
      }
    ]
  })
}
#creating db table for state locking
resource "aws_dynamodb_table" "state_lock_table" {
    name = var.table_name
    billing_mode = PAY_PER_REQUEST
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }
  lifecycle {
    prevent_destroy = true
  }
    tags = {
        Name = var.table_name
    }
}
