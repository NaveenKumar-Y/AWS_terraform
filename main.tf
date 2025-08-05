



module "VPC" {
  source            = "./VPC"
  vpc_ingress_rules = var.ingress_rules
  vpc_egress_rules = var.egress_rules
}

module "external" {
  source = "./external"
}

module "ec2" {
  # depends_on = [ module.external ]
  source                 = "./ec2"
  ssh_pulbic_key_name    = module.external.key_pair
  vpc_security_group_ids = [module.VPC.vpc_sg_id]
  ec2_private_subnet_id          = module.VPC.public_subnet[0]
  ec2_public_subnet_id = module.VPC.private_subnet[0]
  enable_monitoring      = true
  script_version = var.script_version

}


module "rds" {
  source = "./rds"
  vpc_security_group_ids = [module.VPC.vpc_sg_id]
  rds_subnet_ids = module.VPC.public_subnet
  
}