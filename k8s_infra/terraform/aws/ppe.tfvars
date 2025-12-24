env = "ppe"
# AWS VPC variables
aws_region           = "ap-south-1"
public_subnets_cidr  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
private_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

# EKS cluster variables
cluster_name          = "eks-${terraform.workspace}-karpenter"
ami_type_system       = "AL2_x86_64"
instance_types_system = ["t3.small"]
capacity_type_system  = "ON_DEMAND"

min_size_system     = 2
max_size_system     = 3
desired_size_system = 2
disk_size_system    = 80

labels_system = {
  node-role   = "system"
  environment = "${terraform.workspace}"
  terraform   = "true"

  "karpenter.sh/discovery"                       = "eks-${terraform.workspace}-karpenter"
  "cluster/eks-${terraform.workspace}-karpenter" = "shared"
}

taints_system = {
  CriticalAddonsOnly = {
    key    = "CriticalAddonsOnly"
    value  = "true"
    effect = "NO_SCHEDULE"
  }
  SystemAddonsOnly = {
    key    = "SystemAddonsOnly"
    value  = "true"
    effect = "NO_SCHEDULE"
  }
}

node_security_group_tags_system = {
  "karpenter.sh/discovery" = "eks-ppe-karpenter"
}

tags_system = {
  Environment = "${terraform.workspace}"
  Terraform   = "true"
}

cluster_enabled_log_types = [
  "api",
  "audit",
  "authenticator",
  "controllerManager",
  "scheduler",
]
