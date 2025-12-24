module "vpc" {
  # source  = "terraform-aws-modules/vpc/aws"
  # version = "~> 5.0"
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=cf73787bc163944d63a82e0898aee2bc7ade27ca" # commit hash of version 5.0.0

  name = local.vpc_name
  cidr = local.vpc_cidr

  azs             = ["${local.aws_region}a", "${local.aws_region}b", "${local.aws_region}c"]
  private_subnets = local.private_subnets_cidr
  public_subnets  = local.public_subnets_cidr

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_support   = true
  enable_dns_hostnames = true

  # -------- VPC Flow Logs --------
  enable_flow_log = true

  # Tags required for EKS and Karpenter
  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
    "karpenter.sh/discovery"                      = local.cluster_name
  }
}
