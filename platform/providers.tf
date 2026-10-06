# The Helm provider uses the kubeconfig file (the "key") made in layer 1.
provider "helm" {
  kubernetes = {
    config_path = var.kubeconfig_path
  }
}
