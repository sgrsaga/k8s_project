
variable "env" {
  type    = string
  default = "dev"
}

##### AWS VPC variables #####

variable "aws_region" {
  type        = string
  default     = "ap-south-1"
  description = "AWS region"
}

variable "public_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  description = "Public subnets CIDR"
}

variable "private_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  description = "Private subnets CIDR"
}

##### EKS cluster variables #####

variable "cluster_name" {
  type        = string
  default     = "demo-eks-karpenter"
  description = "EKS cluster name"
}

variable "ami_type_system" {
  type        = string
  default     = "AL2_x86_64"
  description = "AMI type"
}

variable "instance_types_system" {
  type        = list(string)
  default     = ["m6i.large"]
  description = "Instance types"
}

variable "capacity_type_system" {
  type        = string
  default     = "ON_DEMAND"
  description = "Capacity type"
}

variable "min_size_system" {
  type        = number
  default     = 2
  description = "Minimum size"
}

variable "max_size_system" {
  type        = number
  default     = 3
  description = "Maximum size"
}

variable "desired_size_system" {
  type        = number
  default     = 2
  description = "Desired size"
}

variable "disk_size_system" {
  type        = number
  default     = 80
  description = "Disk size"
}

variable "labels_system" {
  type = map(string)
  default = {
    "node-role"                                = "system"
    "environment"                              = "dev"
    "terraform"                                = "true"
    "karpenter.sh/discovery"                   = "demo-eks-karpenter"
    "kubernetes.io/cluster/demo-eks-karpenter" = "shared"
  }
  description = "Labels"
}

variable "taints_system" {
  type = list(map(string))
  default = [{
    key    = "CriticalAddonsOnly"
    value  = "true"
    effect = "NO_SCHEDULE"
    },
    {
      key    = "SystemAddonsOnly"
      value  = "true"
      effect = "NO_SCHEDULE"
  }]
  description = "Taints"
}

variable "node_security_group_tags_system" {
  type = map(string)
  default = {
    "karpenter.sh/discovery" = "demo-eks-karpenter"
  }
  description = "Node security group tags"
}

variable "tags_system" {
  type = map(string)
  default = {
    "Environment" = "dev"
    "Terraform"   = "true"
  }
  description = "Tags"
}

variable "cluster_enabled_log_types" {
  type = list(string)
  default = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]
  description = "Cluster enabled log types"
}

