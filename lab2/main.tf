terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Owner = "aleksandr_platonov@epam.com"
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
# #getting data
# data "aws_vpc" "existed_vpc" {
#   id = "vpc-6c6dfe06"
# }

# data "aws_subnet" "existed_subnet" {
#   id = "subnet-2965d455"
# }

# data "aws_security_group" "existed_sg" {
#   id = "sg-0a8b5db2a7dcca42a"
# }



module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = data.aws_ami.aws_ami_selected.id
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = "sg-0a8b5db2a7dcca42a"
  subnet_id              = "subnet-2965d455"

  tags = {
    Owner = "aleksandr_platonov@epam.com"
  }
}

#vpc-6c6dfe06
#subnet-2965d455
#sg-0a8b5db2a7dcca42a