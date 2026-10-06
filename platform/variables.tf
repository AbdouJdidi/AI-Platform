variable "kubeconfig_path" {
  description = "Kubeconfig written by layer 1 (infra/local)"
  type        = string
  default     = "../infra/local/kubeconfig-ai-platform"
}

variable "traefik_chart_version" {
  description = "Exact Traefik Helm chart version (pinned = reproducible)"
  type        = string
  default     = "41.6.1"
}
