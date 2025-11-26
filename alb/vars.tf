variable "aws_vpc_id" {
  description = "The ID of the VPC where the ASG will be deployed"
  type        = string
  
}


# variable "access_logs_bucket" {
#   description = "The name of the S3 bucket for storing access logs"
#   type        = string
  
# }


variable "lb_subnets" {
  description = "List of subnet IDs to attach to the Load Balancer"
  type        = list(string)
  
}


variable "alb_ingress_rules" {
  description = "List of ingress rules for the ALB security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = [ {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]

  } ]
  
}

variable "vpc_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = [ {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    # from_port and to_port set to 0 with protocol = "-1" means "all ports/protocols."
    # This is equivalent to "allow all egress (outbound) traffic."

  } ]
}