
data "aws_ami" "amazon_linux" {

  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }


    filter {
    name   = "name"
    # This regex specifically looks for Amazon Linux 2 AMIs
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] 
  }

  
}


resource "aws_launch_template" "my_app_template" {
  name = "my_app_template"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }

#   capacity_reservation_specification {
#     capacity_reservation_preference = "open"
#   }

#   cpu_options {
#     core_count       = 4
#     threads_per_core = 2
#   }

#   credit_specification {
#     cpu_credits = "standard"
#   }

  disable_api_stop        = true
  disable_api_termination = true

  ebs_optimized = true

  iam_instance_profile {
    name = resource.aws_iam_instance_profile.instance_profile.name
  }

  image_id = data.aws_ami.amazon_linux.id

  instance_initiated_shutdown_behavior = "terminate"

#   instance_market_options {
#     market_type = "spot"
#   }

  instance_type = "t2.micro"

#   kernel_id = "test"

#   key_name = "test"

#   license_specification {
#     license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
#   }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

#   network_interfaces {
#     associate_public_ip_address = false
#   }

#   placement {
#     availability_zone = "us-west-2a"
#   }

#   ram_disk_id = "test"

  vpc_security_group_ids = [var.sg_id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "dev"
    }
  }

  user_data = filebase64("${path.module}/startup_script.sh")
}