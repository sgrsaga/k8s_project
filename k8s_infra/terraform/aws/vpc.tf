module "vpc" {
  # source  = "terraform-aws-modules/vpc/aws"
  # version = "~> 5.0"
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=cf73787bc163944d63a82e0898aee2bc7ade27ca"  # commit hash of version 5.0.0

  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_support   = true
  enable_dns_hostnames = true

  # -------- VPC Flow Logs --------
  enable_flow_log = true

  # Tags required for EKS and Karpenter
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
    "karpenter.sh/discovery"                    = var.cluster_name
  }
}
