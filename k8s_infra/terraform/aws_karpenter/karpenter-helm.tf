resource "kubernetes_namespace" "karpenter" {
  metadata {
    name = "karpenter"
  }

  depends_on = [module.eks]
}

resource "helm_release" "karpenter" {
  name       = "karpenter"
  namespace  = kubernetes_namespace.karpenter.metadata[0].name
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "v1.0.0" # <-- pin to a real version from docs

  create_namespace = false

  values = [
    yamlencode({
      settings = {
        clusterName     = var.cluster_name
        clusterEndpoint = module.eks.cluster_endpoint
      }

      serviceAccount = {
        create = true
        name   = "karpenter"
        annotations = {
          "eks.amazonaws.com/role-arn" = aws_iam_role.karpenter_controller.arn
        }
      }
    })
  ]

  depends_on = [
    module.eks
  ]
}
