output "vpc_sg_id" {
  value = aws_security_group.name.id
  description = "value of the security group ID created for the VPC"
}

output "private_subnet" {
  value = aws_subnet.private[0].id #one(aws_subnet.private[*].id)
}