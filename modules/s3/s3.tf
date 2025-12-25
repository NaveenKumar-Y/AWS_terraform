
resource "aws_s3_bucket" "bucket" {
  # bucket_prefix = var.backend_bucket_prefix
  bucket_prefix = var.bucket_prefix

  tags = {
    Name        = var.bucket_name
  }
}

# resource "aws_s3_bucket_versioning" "s3_versioning" {
#     bucket = aws_s3_bucket.backend_bucket.id
    
#     versioning_configuration {
#         status = "Enabled"
#     }
# }


moved {
  from = aws_s3_bucket.backend_bucket
    to   = aws_s3_bucket.bucket
}