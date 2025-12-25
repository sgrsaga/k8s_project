# use the environment variable to set the relevant values for the cluster

locals {

  project_name = var.project_name

  # Region specific values
  aws_region = var.aws_region
  vpc_cidr   = var.vpc_cidr

  # VPC specific values
  vpc_name             = "${var.env}-vpc-demo"
  private_subnets_cidr = var.private_subnets_cidr
  public_subnets_cidr  = var.public_subnets_cidr

  # EKS specific values
  kubernetes_version              = var.kubernetes_version
  cluster_enabled_log_types       = var.cluster_enabled_log_types
  ami_type_system                 = var.ami_type_system
  instance_types_system           = var.instance_types_system
  min_size_system                 = var.min_size_system
  max_size_system                 = var.max_size_system
  desired_size_system             = var.desired_size_system
  capacity_type_system            = var.capacity_type_system
  disk_size_system                = var.disk_size_system
  labels_system                   = var.labels_system
  taints_system                   = var.taints_system
  node_security_group_tags_system = var.node_security_group_tags_system
  tags_system                     = var.tags_system

}
