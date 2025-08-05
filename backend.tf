
# data "terraform_remote_state" "s3_backend" {
#   backend = "remote"

#   config = {
#     organization = "Naveen_org"
#     workspaces = {
#       name = "aws-s3-bucket-kk"
#     }
#   }
  
# }


# locals {
#   backend_s3_bucket_name = data.terraform_remote_state.s3_backend.outputs.backend_s3_bucket_name
# }

# terraform {
#   backend "s3" {
#     bucket = "state-file-bucket20250626072240363800000001"
#     # bucket_prefix = "state-file-bucket"
#     # bucket = locals.backend_s3_bucket_name
#     key    = "demo/terraform.tfstate"
#     region = "us-east-1"
#     profile = "naveen"
#     dynamodb_table = "terraform-state-lock"
#     encrypt = true
    
#   }
# }
