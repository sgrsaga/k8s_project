# module "eks" {
#   # source  = "terraform-aws-modules/eks/aws"
#   # version = "~> 21.10.0"
#   source = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=943fd575bcaddaf3b97101ecd7321e79ae67f68b" # commit hash of version 21.10.0

#   name               = local.cluster_name
#   kubernetes_version = local.kubernetes_version

#   vpc_id                   = module.vpc.vpc_id
#   subnet_ids               = module.vpc.private_subnets
#   control_plane_subnet_ids = module.vpc.private_subnets

#   enable_irsa = true

#   endpoint_private_access = true
#   endpoint_public_access  = false

#   # Enable control plane logs
#   enabled_log_types = local.cluster_enabled_log_types

#   # Small on-demand system node group
#   eks_managed_node_groups = {
#     system = {
#       ami_type       = local.ami_type_system
#       instance_types = local.instance_types_system

#       min_size     = local.min_size_system
#       max_size     = local.max_size_system
#       desired_size = local.desired_size_system

#       capacity_type = local.capacity_type_system

#       subnet_ids = module.vpc.private_subnets

#       disk_size = local.disk_size_system

#       labels = local.labels_system

#       # Optional: taint to keep app pods off system nodes
#       # Then your core addons tolerate this taint.
#       taints = local.taints_system
#     }
#   }

#   # Tag the node security group for Karpenter
#   node_security_group_tags = local.node_security_group_tags_system

#   tags = local.tags_system
# }
