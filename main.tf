

module "VPC" {
  source            = "./VPC"
  vpc_ingress_rules = var.vpc_ingress_rules
}

module "external" {
  source = "./external"
}

module "ec2" {
  # depends_on = [ module.external ]
  source                 = "./ec2"
  ssh_pulbic_key_name    = module.external.key_pair
  vpc_security_group_ids = [module.VPC.vpc_sg_id]
  ec2_subnet_id          = module.VPC.private_subnet
  enable_monitoring      = true
}