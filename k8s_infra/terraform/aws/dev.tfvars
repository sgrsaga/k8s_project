
env = "dev"

##### AWS VPC variables #####

aws_region = "ap-south-1"
public_subnets_cidr = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
private_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

##### EKS cluster variables #####

cluster_name = "demo-eks-karpenter"
ami_type_system = "AL2_x86_64"
instance_types_system = ["m6i.large"]
capacity_type_system = "ON_DEMAND"
min_size_system = 2
max_size_system = 3
desired_size_system = 2
disk_size_system = 80
labels_system = {
  node-role                                  = system
  environment                                = dev
  terraform                                  = true
  "karpenter.sh/discovery"                   = demo-eks-karpenter
  "kubernetes.io/cluster/demo-eks-karpenter" = shared
}
taints_system = [
  {
    key    = CriticalAddonsOnly
    value  = true
    effect = NO_SCHEDULE
  },
  {
    key    = SystemAddonsOnly
    value  = true
    effect = NO_SCHEDULE
  },
]
node_security_group_tags_system = {
  "karpenter.sh/discovery" = demo-eks-karpenter
}
tags_system = {
  Environment = dev
  Terraform   = true
}
cluster_enabled_log_types = [
  "api",
  "audit",
  "authenticator",
  "controllerManager",
  "scheduler",
]
