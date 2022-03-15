#vpcs
data "aws_vpcs" "vpcs" {}

output "vpcs" {
  value = data.aws_vpcs.vpcs.ids
}

#subnets
data "aws_subnets" "subnets" {}

output "subnets" {
  value = data.aws_subnets.subnets.ids
}

#cidr
data "aws_subnet" "subnet_cidr" {
  for_each = { for i, subnetid in data.aws_subnets.subnets.ids : i => subnetid }
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.subnet_cidr : s.cidr_block]
}

#asg
data "aws_security_groups" "asg" {
  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.vpcs.ids
  }
}

output "asg" {
  value = data.aws_security_groups.asg.ids
}