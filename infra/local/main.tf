# It just USES the module, like calling a function with arguments.

module "cluster" {
  source = "../modules/kind-cluster"

  cluster_name    = var.cluster_name
  worker_count    = var.worker_count
  kubeconfig_path = abspath("${path.root}/kubeconfig-${var.cluster_name}")
  http_port       = var.http_port
  https_port = var.https_port
  
}
