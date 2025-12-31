env          = "ppe"
project_name = "aws-eks-ppe"
# AWS VPC variables
aws_region           = "ap-south-1"
vpc_cidr             = "10.0.0.0/16"
public_subnets_cidr  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
private_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

# EKS cluster variables
cluster_name          = "aws-eks-ppe"
kubernetes_version    = "1.32"
ami_type_system       = "AL2023_x86_64_STANDARD"
instance_types_system = ["t3.medium"]
capacity_type_system  = "ON_DEMAND"

min_size_system     = 2
max_size_system     = 3
desired_size_system = 2
disk_size_system    = 80

labels_system = {
  node-role   = "system"
  environment = "ppe"
  terraform   = "true"

  "karpenter.sh/discovery" = "eks-ppe"
  "cluster/eks-ppe"        = "shared"
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
  "karpenter.sh/discovery" = "eks-ppe"
}

tags_system = {
  Environment = "ppe"
  Terraform   = "true"
}

cluster_enabled_log_types = [
  "api",
  "audit",
  "authenticator",
  "controllerManager",
  "scheduler",
]
