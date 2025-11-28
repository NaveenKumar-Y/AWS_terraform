

resource "aws_autoscaling_group" "my_app_asg" {
  name_prefix                      = "my_app_asg"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 60  # When a new instance starts, the ASG ignores all health check failures for this duration to give the server time to boot and install software.
#   health_check_type         = "ELB"
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
#   placement_group           = aws_placement_group.test.id
#   launch_configuration      = aws_launch_configuration.foobar.name
  launch_template {
    id      = aws_launch_template.my_app_template.id
    # version = "$Latest"  ## Passive. No rollout.
    version = aws_launch_template.my_app_template.latest_version ## Active. Triggers rollout of ASG on every change.
  }
  vpc_zone_identifier       = var.private_subnets   # list of subnet IDs that define where EC2 instances can be deployed.

  instance_maintenance_policy {
    min_healthy_percentage = 90        # During instance refresh or replacement, at least 90% of desired capacity should be healthy.
    max_healthy_percentage = 120     # During instance refresh or replacement, the ASG can temporarily exceed desired capacity by up to 20%.
  }

  initial_lifecycle_hook {
    name                 = "wait_for_user_data_script_completion"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 60
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

    notification_metadata = jsonencode({
      foo = "bar"
    })

    #NOTE:  Without this hook, the ASG might verify the EC2 status checks (System Reachability) pass and immediately add it to the Load Balancer. However, your User Data script (installing Apache, downloading code) might still be running!

    # notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
    # role_arn                = "arn:aws:iam::123456789012:role/S3Access"
  }


  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    # triggers = ["launch_template"]  #'launch_template' always triggers an instance refresh and can be not mentioned explictily
  }

  tag {
    key                 = "created_by"
    value               = "my_app_asg"
    propagate_at_launch = true    # add the tag in EC2 instances as well.
  }

#   timeouts {
#     delete = "15m"
#   }

    # lifecycle {
    #   create_before_destroy = true
    # }

    target_group_arns = [var.target_group_arn]

}