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
  default_tags  {
      tags = {
          Owner = "aleksandr_platonov@epam.com"
      }
  }
}

data "aws_ami" "aws_ami_selected" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}


 ami                         = "${data.aws_ami.aws_ami_selected.id}"
 associate_public_ip_address = true
 instance_type               = "t2.micro"
 key_name                    = "bflad-20180605"
 vpc_security_group_ids      = ["${aws_security_group.test.id}"]
 subnet_id                   = "${aws_subnet.test.id}"