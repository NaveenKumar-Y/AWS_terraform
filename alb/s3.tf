

module "s3_for_asg" {
  source = "../s3"

  bucket_prefix = "asg-access-logs-"
  bucket_name   = "myapp-asg-access-logs-bucket"
  
}