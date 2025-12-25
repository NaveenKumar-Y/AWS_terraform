resource "aws_lb" "myapp_alb" {
  name               = "my-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.lb_subnets #  List of subnet IDs to attach to the LB. #LB in public subnets (one in each AZ for HA).

  enable_deletion_protection = true

  access_logs {
    bucket  = module.s3_for_asg.s3_bucket_id
    prefix  = "myapp-lb"
    enabled = true
  }

  tags = {
    Environment = "dev"
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_security_group" "lb_sg" {

  name        = "lb_security_group"
  description = "Security group for Load Balancer"
  vpc_id      = var.aws_vpc_id

  dynamic "ingress" {
    for_each = var.alb_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks

    #   description      = "Allow traffic from ALB" # Optional but good practice
    #   ipv6_cidr_blocks = []
    #   prefix_list_ids  = []
    #   security_groups  = []
    #   self             = false
    }
  }

  dynamic "egress" {
    for_each = var.vpc_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}


# aws_lb_target_group = defines the pool and its health-checks, scoped to a VPC.

# aws_lb_target_group_attachment = actually adds resources to that pool.

# aws_lb_listener = receives traffic and forwards it to the pool.

# Create the target group
resource "aws_lb_target_group" "my_app_tg" {
  depends_on = [ aws_lb.myapp_alb ]
  name     = "web-targets"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.aws_vpc_id

  load_balancing_algorithm_type = "least_outstanding_requests"

  health_check {
    path     = "/"
    protocol = "HTTP"
  }
}


# Add a listener to ALB
resource "aws_lb_listener" "my_app_listener" {
  load_balancer_arn = aws_lb.myapp_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_app_tg.arn
  }
}

