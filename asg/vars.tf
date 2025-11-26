variable "sg_id" {
  description = "The security group ID to associate with the ASG instances"
  type        = string
  
}

variable "private_subnets" {
  description = "List of private subnet IDs for the ASG"
  type        = list(string)
  
}

variable "target_group_arn" {
  description = "The ARN of the target group to attach to the ASG"
  type        = string
  
}