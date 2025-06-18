variable "ssh_pulbic_key_name" {
  description = "Name of the SSH key pair to use for EC2 instances."
  type        = string
  
}

variable "vpc_security_group_ids" {
    type = list(string)
    description = "List of security group IDs to associate with the EC2 instance."
}

variable "ec2_subnet_id" {
  type = string
    description = "The ID of the subnet in which to launch the EC2 instance."
}


variable "enable_monitoring" {
  type = bool
    description = "Whether to enable detailed monitoring for EC2 instances."
    default = true
}