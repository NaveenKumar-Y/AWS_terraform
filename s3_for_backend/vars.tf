variable "backend_bucket_prefix" {
  type        = string
  description = "Prefix for the S3 bucket used for storing Terraform state files."
  default     = "state-file-bucket"
  
}