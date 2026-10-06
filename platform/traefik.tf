# Traefik = the ingress controller, the cluster's "receptionist".
# It receives every web request and sends it to the right app.

resource "helm_release" "traefik" {
  name             = "traefik"
  repository       = "https://traefik.github.io/charts"
  chart            = "traefik"
  version          = var.traefik_chart_version
  namespace        = "traefik"
  create_namespace = true
  wait             = true
  timeout          = 600

  values = [yamlencode({
    deployment = {
      replicas = 1
    }

    # Run Traefik on the control-plane node, because that's the node
    # where we mapped laptop ports (8090/8453) to node ports (80/443).
    nodeSelector = {
      "ingress-ready" = "true"
    }

    # The control plane has a "taint" (a "keep out" sign) so normal apps
    # don't run there. This toleration lets Traefik ignore that sign.
    tolerations = [{
      key      = "node-role.kubernetes.io/control-plane"
      operator = "Exists"
      effect   = "NoSchedule"
    }]

    # Listen directly on the node's ports 80 and 443.
    ports = {
      web       = { hostPort = 80 }
      websecure = { hostPort = 443 }
    }

    # No cloud load balancer on a laptop, so a simple internal Service.
    service = {
      spec = { type = "ClusterIP" }
    }

    # Always set limits: protects your 16 GB of RAM.
    resources = {
      requests = { cpu = "50m", memory = "64Mi" }
      limits   = { cpu = "300m", memory = "256Mi" }
    }

    # Make Traefik the default for any Ingress that doesn't name a class.
    ingressClass = {
      enabled        = true
      isDefaultClass = true
    }
  })]
}
