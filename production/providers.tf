terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.0.0"
    }
     #tls = {
     # source = "hashicorp/tls"
      #version = "4.0.5"
    #}
  }
}

provider "aws"{
  # Configuration options
  region = "eu-central-1"
  profile = "default"
}

