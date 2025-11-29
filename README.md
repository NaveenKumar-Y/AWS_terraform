# AWS Terraform Project

This repository contains Terraform files for provisioning and setting up resources in AWS. It includes configurations for creating VPCs, subnets, security groups, EC2 instances, and more.

## Prerequisites

Before you can run Terraform, make sure you have the following:

- An AWS account with the necessary permissions
- Terraform installed on your machine
- An SSH key pair created in AWS

## Getting Started

To get started with this project, follow these steps:

1. Clone this repository to your local machine.
2. Configure your AWS credentials using the AWS CLI or by setting environment variables.
3. Create a new directory for your Terraform workspace.
4. Copy the contents of the `Practice_project` directory into your new workspace directory.
5. Open a terminal and navigate to your workspace directory.
6. Run `terraform init` to initialize the Terraform configuration.
7. Run `terraform plan` to see a preview of the changes that will be made.
8. Run `terraform apply` to apply the changes and provision the resources.

## Configuration

You can customize the Terraform configuration by modifying the variables in the `variables.tf` file. Some of the variables include:

- `aws_region`: The AWS region where the resources will be provisioned.
- `vpc_cidr_block`: The CIDR block for the VPC.
- `public_subnet_cidr_block`: The CIDR block for the public subnet.
- `private_subnet_cidr_block`: The CIDR block for the private subnet.
