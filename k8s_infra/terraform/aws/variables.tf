# Environment
variable "env" {
  type        = string
  description = "Environment"
  default     = "dev"
}

# AWS VPC variables

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "Public subnets CIDR"
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "Private subnets CIDR"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

# EKS cluster variables

# variable "cluster_name" {
#   type        = string
#   description = "EKS cluster name"
#   default     = "demo-eks-karpenter"
# }

# variable "kubernetes_version" {
#   type        = string
#   description = "Kubernetes version"
#   default     = "1.30"
# }

# variable "ami_type_system" {
#   type        = string
#   description = "AMI type"
#   default     = "AL2_x86_64"
# }

# variable "instance_types_system" {
#   type        = list(string)
#   description = "Instance types"
#   default     = ["m6i.large"]
# }

# variable "capacity_type_system" {
#   type        = string
#   description = "Capacity type"
#   default     = "ON_DEMAND"
# }

# variable "min_size_system" {
#   type        = number
#   description = "Minimum size"
#   default     = 2
# }

# variable "max_size_system" {
#   type        = number
#   description = "Maximum size"
#   default     = 3
# }

# variable "desired_size_system" {
#   type        = number
#   description = "Desired size"
#   default     = 2
# }

# variable "disk_size_system" {
#   type        = number
#   description = "Disk size"
#   default     = 80
# }

# variable "labels_system" {
#   type        = map(string)
#   description = "Labels"

#   default = {
#     "node-role"                  = "system"
#     environment                  = "dev"
#     terraform                    = "true"
#     "karpenter.sh/discovery"     = "demo-eks-karpenter"
#     "cluster/demo-eks-karpenter" = "shared"
#   }
# }

# variable "taints_system" {
#   type = map(object({
#     key    = string
#     value  = string
#     effect = string
#   }))
#   description = "Taints"

#   default = {
#     CriticalAddonsOnly = {
#       key    = "CriticalAddonsOnly"
#       value  = "true"
#       effect = "NO_SCHEDULE"
#     }
#     SystemAddonsOnly = {
#       key    = "SystemAddonsOnly"
#       value  = "true"
#       effect = "NO_SCHEDULE"
#     }
#   }
# }

# variable "node_security_group_tags_system" {
#   type        = map(string)
#   description = "Node security group tags"

#   default = {
#     "karpenter.sh/discovery" = "demo-eks-karpenter"
#   }
# }

# variable "tags_system" {
#   type        = map(string)
#   description = "Tags"

#   default = {
#     Environment = "dev"
#     Terraform   = "true"
#   }
# }

# variable "cluster_enabled_log_types" {
#   type        = list(string)
#   description = "Cluster enabled log types"

#   default = [
#     "api",
#     "audit",
#     "authenticator",
#     "controllerManager",
#     "scheduler",
#   ]
# }
