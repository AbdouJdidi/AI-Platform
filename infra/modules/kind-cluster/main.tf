# The actual thing we build: one Kubernetes cluster made of Docker containers.

resource "kind_cluster" "this" {
  name            = var.cluster_name
  node_image      = var.node_image
  kubeconfig_path = var.kubeconfig_path
  wait_for_ready  = true # don't finish until the cluster is really up

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    # The control plane = the "brain" of Kubernetes.
    node {
      role = "control-plane"

      # Label this node so the ingress controller (next step) knows where to run.
      kubeadm_config_patches = [
        <<-EOT
        kind: InitConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "ingress-ready=true"
        EOT
      ]

      # Open doors from your laptop into the cluster (for websites later).
      extra_port_mappings {
        container_port = 80
        host_port      = var.http_port
      }
      extra_port_mappings {
        container_port = 443
        host_port      = var.https_port
      }
    }

    # Workers = the "muscles" where your apps run. One block per worker.
    dynamic "node" {
      for_each = range(var.worker_count)
      content {
        role = "worker"
      }
    }
  }
}
