# EC2NodeClass: describes AWS-specific config for nodes

resource "kubernetes_manifest" "karpenter_ec2_nodeclass_default" {
  manifest = {
    "apiVersion" = "karpenter.k8s.aws/v1beta1"
    "kind"       = "EC2NodeClass"
    "metadata" = {
      "name" = "default"
    }
    "spec" = {
      "amiFamily" = "AL2"

      "role"            = aws_iam_role.karpenter_node.arn
      "instanceProfile" = aws_iam_instance_profile.karpenter_node.name

      # Select subnets and security groups by tags
      "subnetSelectorTerms" = [
        {
          "tags" = {
            "kubernetes.io/cluster/${var.cluster_name}" = "shared"
          }
        }
      ]
      "securityGroupSelectorTerms" = [
        {
          "tags" = {
            "karpenter.sh/discovery" = var.cluster_name
          }
        }
      ]

      # Optional: custom EBS size, etc.
      "blockDeviceMappings" = [
        {
          "deviceName" = "/dev/xvda"
          "ebs" = {
            "volumeSize" = 100
            "volumeType" = "gp3"
            "encrypted"  = true
          }
        }
      ]
    }
  }

  depends_on = [
    data.aws_eks_cluster.this,
    helm_release.karpenter
  ]
}

# NodePool: mainly Spot, multiple instance families

resource "kubernetes_manifest" "karpenter_nodepool_spot" {
  manifest = {
    "apiVersion" = "karpenter.sh/v1beta1"
    "kind"       = "NodePool"
    "metadata" = {
      "name" = "spot-general"
    }
    "spec" = {
      "template" = {
        "spec" = {
          "nodeClassRef" = {
            "name" = kubernetes_manifest.karpenter_ec2_nodeclass_default.manifest.metadata.name
          }

          "requirements" = [
            {
              "key"      = "kubernetes.io/arch"
              "operator" = "In"
              "values"   = ["amd64"]
            },
            {
              "key"      = "karpenter.k8s.aws/instance-family"
              "operator" = "In"
              "values"   = ["m6i", "m5", "c6i", "c5"]
            },
            {
              "key"      = "karpenter.k8s.aws/capacity-type"
              "operator" = "In"
              "values"   = ["spot"]
            }
          ]

          "labels" = {
            "node-role" = "app"
          }

          # Tolerations so app pods can get scheduled correctly if you use taints
          "taints" = []
        }
      }

      # Optional: global limits to avoid runaway costs
      "limits" = {
        "cpu" = "200"
      }

      "disruption" = {
        "consolidationPolicy" = "WhenEmptyOrUnderutilized"
        "consolidateAfter"    = "30s"
      }
    }
  }

  depends_on = [
    kubernetes_manifest.karpenter_ec2_nodeclass_default
  ]
}
