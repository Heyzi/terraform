terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
locals {
  tags = {
    Owner       = var.owner
    Environment = var.environment
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Owner       = var.owner
      Environment = var.environment
    }
  }
}

data "aws_ami" "aws_ami_selected" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}
resource "aws_instance" "ec2_server1" {
  ami                    = data.aws_ami.aws_ami_selected.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0a8b5db2a7dcca42a"]
  subnet_id              = "subnet-2965d455"
  user_data              = file("userdata.sh")


  volume_tags = {
    Owner       = var.owner
    Name        = "mytrashEC2"
    Environment = var.environment
  }
}
