output "instance_ids" {
  description = "List of EC2 instance IDs created by the module."
  value       = aws_instance.my_instance.id
}

output "ec2_public_ip" {
  value = aws_instance.my_instance.public_ip
}