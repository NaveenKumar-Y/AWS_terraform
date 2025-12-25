variable "ssh_pulbic_key_name" {
  description = "Name of the SSH key pair to use for EC2 instances."
  type        = string

}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the EC2 instance."
}

variable "ec2_private_subnet_id" {
  type        = string
  description = "The ID of the subnet in which to launch the EC2 instance."
}

variable "ec2_public_subnet_id" {
  type        = string
  description = "The ID of the public subnet in which to launch the EC2 instance."
}


variable "enable_monitoring" {
  type        = bool
  description = "Whether to enable detailed monitoring for EC2 instances."
  default     = true
}


variable "script_version" {
  type        = string
  description = "Version of the startup script to be used."
  default     = "1.0"
  
}

# variable "ec2_ingress_rules" {
#   type = list(object({
#     from_port   = number
#     to_port     = number
#     protocol    = string
#     cidr_blocks = list(string)
#   }))
#   description = "List of ingress rules for the EC2 instance security group."
#   default     = []
  
# }

# variable "ec2_egress_rules" {
#   type = list(object({
#     from_port   = number
#     to_port     = number
#     protocol    = string
#     cidr_blocks = list(string)
#   }))
#   description = "List of egress rules for the EC2 instance security group."
#   default     = []
  
# }