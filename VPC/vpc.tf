locals {
  cidr_private = cidrsubnet(aws_vpc.custom1[0].cidr_block,4,0)
  cidr_public  = cidrsubnet(aws_vpc.custom1[0].cidr_block,4,1)
}


resource "aws_vpc" "custom1" {
    count  = var.create_vpc ? 1 : 0
    cidr_block = var.vpc_cidr_range
    instance_tenancy = var.instance_tenancy

    enable_dns_hostnames = var.enable_dns_hostnames
    enable_dns_support   = true


    tags = merge({"purpose" = "practice"},var.tags)
}

locals {
  # az_zones = var.az_zones
  public_subnet_cidrs = [for i in range(var.public_subnet_count) : cidrsubnet(local.cidr_public, 4, i)]
  private_subnet_cidrs = [for i in range(var.private_subnet_count) : cidrsubnet(local.cidr_private, 4, i)]
}


resource "aws_subnet" "public" {
    count = var.create_vpc ? var.public_subnet_count : 0
    vpc_id = aws_vpc.custom1[0].id
    cidr_block = local.public_subnet_cidrs[count.index]
    availability_zone = element(var.az_zones, count.index)
}

resource "aws_subnet" "private" {
    count = var.create_vpc ? var.private_subnet_count : 0
    vpc_id = aws_vpc.custom1[0].id
    cidr_block = local.private_subnet_cidrs[count.index]
    availability_zone = element(var.az_zones, count.index)
}


resource "aws_security_group" "name" {
  name = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id = aws_vpc.custom1[0].id

  dynamic "ingress" {
    for_each = var.vpc_ingress_rules
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks 
    }
  }

  dynamic "egress" {
    for_each = var.vpc_egress_rules
    content{
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks 
    }
    
  }

  
}