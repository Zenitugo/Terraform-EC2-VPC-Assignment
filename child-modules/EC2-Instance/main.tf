# Create ec2 instance
resource "aws_instance" "vm" {
    count = 2
    ami           = var.instance_ami
    instance_type = var.ec2_instance_type
    key_name = aws_key_pair.testkey.id
    subnet_id = [var.private_subnet_id, var.public_subnet_id][count.index]
    vpc_security_group_ids = [aws_security_group.sg-group.id]

  tags = {
    Name = var.instance_name
    environment = var.environment
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install -y software-properties-common python-apt-common
    sudo apt install -y ansible
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    sudo apt-cache policy docker-ce
    sudo apt install docker.io -y
    sudo systemctl enable docker.service
    sudo systemctl status docker
EOF
}

#######################################################################################################################
######################################################################################################################

# Create a key pair
resource "aws_key_pair" "testkey" {
  key_name = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Create a Private key
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Put the private key in a local file
resource "local_file" "testkey_private" {
  content = tls_private_key.ssh_key.private_key_pem
  filename = var.key_filename
}


######################################################################################################################
######################################################################################################################


# CREATE A SECURITY GROUP
resource "aws_security_group" "sg-group" {
  name        = var.security-name
  vpc_id      = var.vpc_id_id
  

  
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tcp"
  }
}










