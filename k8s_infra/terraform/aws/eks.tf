module "eks" {
  # source  = "terraform-aws-modules/eks/aws"
  # version = "~> 21.10.0"
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=943fd575bcaddaf3b97101ecd7321e79ae67f68b" # commit hash of version 21.10.0

  name               = var.cluster_name
  kubernetes_version = "1.30"

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  endpoint_private_access = true
  endpoint_public_access  = false

  # Enable control plane logs
  enabled_log_types = var.cluster_enabled_log_types

  # encryption_config = {
  #   resources = var.cluster_enabled_log_types
  #   provider {
  #     key_arn = var.cluster_encryption_key_arn
  #   }
  # }
  # Small on-demand system node group
  eks_managed_node_groups = {
    system = {
      ami_type       = var.ami_type_system
      instance_types = var.instance_types_system

      min_size     = var.min_size_system
      max_size     = var.max_size_system
      desired_size = var.desired_size_system

      capacity_type = var.capacity_type_system

      subnet_ids = module.vpc.private_subnets

      disk_size = var.disk_size_system

      labels = var.labels_system

      # Optional: taint to keep app pods off system nodes
      # Then your core addons tolerate this taint.
      taints = var.taints_system
    }
  }

  # Tag the node security group for Karpenter
  node_security_group_tags = var.node_security_group_tags_system

  tags = var.tags_system
}
