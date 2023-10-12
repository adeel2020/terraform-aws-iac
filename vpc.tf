module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.VPC-Name
  cidr = var.VpcCIDR

  azs = [var.zone1, var.zone2, var.zone3]
  private_subnets = [var.privsub1,var.privsub2, var.privsub3]
  public_subnets = [var.pubsub1, var.pubsub2,var.pubsub3]

  enable_dns_hostnames = true
  enable_dns_support = true
  enable_nat_gateway = true
  single_nat_gateway = true 

  tags = {
    Terraform = "true"
    Environment = "prod"
  }
}