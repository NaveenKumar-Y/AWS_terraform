

# Attach asg to lb


# you cannot use aws_lb_target_group_attachment to attach an Auto Scaling Group (ASG). That resource is for attaching specific, static IDs (like a single EC2 Instance ID or a Lambda).

## THIS NOT VALID!!!!!!!!!!!
# resource "aws_lb_target_group_attachment" "my_app" {
#   target_group_arn = var.target_group_arn
#   target_id        = resource.aws_autoscaling_group.my_app_asg.id      #aws_instance.web1.id
#   port             = 80
# }

## SOLUTION: attach directly in ASG resource defination itself


# (or) use aws_autoscaling_attachment
###
# resource "aws_autoscaling_attachment" "asg_attachment" {
#   autoscaling_group_name = aws_autoscaling_group.my_app_asg.id
#   lb_target_group_arn    = var.target_group_arn
# }