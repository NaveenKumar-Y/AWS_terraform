
resource "random_integer" "suffix" {
  min = 10000
  max = 999999
}

resource "aws_s3_bucket" "backend_bucket" {
  # bucket_prefix = var.backend_bucket_prefix
  bucket_prefix = "state-file-bucket-${random_integer.suffix.result}"

  tags = {
    Name        = "StateFileBucket"
  }
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
    bucket = aws_s3_bucket.backend_bucket.id
    
    versioning_configuration {
        status = "Enabled"
    }
}


resource "aws_dynamodb_table" "terraform_lock_table" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "TerraformStateLockTable"
  }
}