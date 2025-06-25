variable "rds_subnet_ids" {
  description = "List of subnet IDs for RDS instances"
  type        = list(string)
  default     = []
  
}


variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the RDS instance"
  type        = list(string)
  default     = []
  
}