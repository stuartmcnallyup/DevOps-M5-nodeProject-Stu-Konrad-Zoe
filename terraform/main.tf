terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.73.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
  access_key = var.access_key 
  secret_key = var.secret_key 
}

module "ec2_ci" {
  source = "./EC2"
  subnet_id = module.subnet01.subnet_id
  security_group_id = module.sg01.security_group_id
  key_name = aws_key_pair.key.key_name
}

module "ec2_deployment" {
  source = "./EC2"
  subnet_id = module.subnet02.subnet_id
  security_group_id = module.sg01.security_group_id
  key_name = aws_key_pair.key.key_name
}

module "vpc" {
  source = "./VPC"
}

module "subnet01" {
  source = "./SUBNET"
  vpc_id = module.vpc.vpc_id
  cidr_block = "10.0.1.0/23"
  availability_zone = "eu-west-2a"
  route_table_id = module.vpc.route_table_id
}

module "subnet02" {
  source = "./SUBNET"
  vpc_id = module.vpc.vpc_id
  cidr_block = "10.0.2.0/23"
  availability_zone = "eu-west-2b"
  route_table_id = module.vpc.route_table_id
}

module "sg01" {
  source = "./SG"
  vpc_id = module.vpc.vpc_id
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key" {
  key_name   = "lab5-key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_sensitive_file" "pem" {
  content         = tls_private_key.key.private_key_pem
  filename        = "lab5-key.pem"
  file_permission = "0400"
}
