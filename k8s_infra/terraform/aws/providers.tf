terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.26.0"
      # source = "git::https://github.com/hashicorp/terraform-provider-aws.git?ref=6332785f824190e00a78d2318750efb0c4bbabe4" # commit hash of version v6.26.0
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 3.0.1"
      # source = "git::https://github.com/hashicorp/terraform-provider-kubernetes.git?ref=8309126c965216bc854d62fd4596070f8169a0f7" # commit hash of version v3.0.1
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.1.1"
      # source = "git::https://github.com/hashicorp/terraform-provider-helm.git?ref=1cbf08f6a306ab3cdff6079b87a61c7641b64f3b" # commit hash of version v3.1.1
    }
  }
  # cloud {
  #   organization = "SGR-DEMO-EKS-YUM5FIM3HO4ZHRF"
  #   workspaces {
  #     tags = ["SGR-DEMO-EKS-YUM5FIM3HO4ZHRF"]
  #   }
  # }
}

provider "aws" {
  region = local.aws_region
}

# Wait for EKS cluster to be fully ready before configuring Kubernetes provider
# Using data source to ensure cluster exists and is accessible
# data "aws_eks_cluster" "this" {
#   name       = module.eks.cluster_name
#   depends_on = [module.eks]
# }

# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     args = [
#       "eks",
#       "get-token",
#       "--cluster-name",
#       module.eks.cluster_name
#     ]
#     env = {
#       AWS_REGION = locals.aws_region
#     }
#   }
# }

# provider "helm" {
#   kubernetes {
#     host                   = module.eks.cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       command     = "aws"
#       args = [
#         "eks",
#         "get-token",
#         "--cluster-name",
#         module.eks.cluster_name
#       ]
#       env = {
#         AWS_REGION = locals.aws_region
#       }
#     }
#   }
# }
