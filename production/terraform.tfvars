instance_name                     = "VM-2"
instance_ami                      = "ami-06dd92ecc74fdfb36"
ec2_instance_type                 = "t2.micro"
key_name                          = "mykeypair"
key_filename                      = "/home/ubuntu/.ssh/id_rsa"
security-name                     = "security-central"
environment                       = "prod"
cidr_block                        = "10.58.0.0/16"
vpc_name                          = "VPC-Central"
public_subnet                     = "10.58.1.0/24"
private_subnet                    = "10.58.2.0/24"