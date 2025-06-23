terraform {
  backend "s3" {
    bucket = "state-file-bucket20250623100405519000000001"
    # bucket_prefix = "state-file-bucket"
    key    = "demo/terraform.tfstate"
    region = "us-east-1"
    profile = "naveen"
    dynamodb_table = "terraform-state-lock"
    encrypt = true
  }
}
