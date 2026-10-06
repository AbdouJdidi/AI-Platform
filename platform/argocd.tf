# Argo CD = the GitOps robot.
# It watches your GitHub repo and makes the cluster match what's in Git.

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argocd_chart_version
  namespace        = "argocd"
  create_namespace = true
  wait             = true
  timeout          = 900

  # Traefik must exist first, because Argo CD's web UI uses an Ingress.
  depends_on = [helm_release.traefik]

  values = [yamlencode({
    global = {
      domain = "argocd.localhost"
    }

    configs = {
      params = {
        # Traefik in front handles the web traffic, so Argo CD itself
        # serves plain HTTP inside the cluster (fine for a local lab).
        "server.insecure" = true
      }
    }

    # Web UI reachable at http://argocd.localhost:8090 through Traefik.
    server = {
      ingress = {
        enabled          = true
        ingressClassName = "traefik"
      }
      resources = {
        requests = { cpu = "50m", memory = "128Mi" }
        limits   = { memory = "256Mi" }
      }
    }

    # Turn off parts we don't need yet, to save RAM.
    dex           = { enabled = false } # single sign-on (SSO)
    notifications = { enabled = false } # Slack/email alerts

    controller = {
      resources = {
        requests = { cpu = "100m", memory = "256Mi" }
        limits   = { memory = "512Mi" }
      }
    }
    repoServer = {
      resources = {
        requests = { cpu = "50m", memory = "128Mi" }
        limits   = { memory = "256Mi" }
      }
    }
  })]
}
