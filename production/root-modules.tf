
module "EC2_Instance" {
  source                           = "../child-modules/EC2-Instance"
  
 instance_name                     = var.instance_name
 instance_ami                      = var.instance_ami
 ec2_instance_type                 = var.ec2_instance_type
 key_name                          = var.key_name
 key_filename                      = var.key_filename
 security-name                     = var.security-name
 vpc_id_id                         = module.network.vpc_id_id
 private_subnet_id                 = module.network.private_subnet_id
 public_subnet_id                  = module.network.public_subnet_id
 environment                       = var.environment
}
 



module "network" {
  source                           = "../child-modules/network"
  environment                      = var.environment
  cidr_block                       = var.cidr_block
  vpc_name                         = var.vpc_name
  public_subnet                    = var.public_subnet
  private_subnet                   = var.private_subnet
}
