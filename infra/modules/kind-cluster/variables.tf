# Inputs of the module: the "settings" someone can change when using it.

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "worker_count" {
  description = "How many worker nodes to create (keep it small on a 16 GB laptop)"
  type        = number
  default     = 2

  validation {
    condition     = var.worker_count >= 0 && var.worker_count <= 3
    error_message = "worker_count must be between 0 and 3 to fit in laptop RAM."
  }
}

variable "node_image" {
  description = "kindest/node image to pin the Kubernetes version (null = kind's default)"
  type        = string
  default     = null
}

variable "kubeconfig_path" {
  description = "Where to write the kubeconfig file (the 'key' to talk to the cluster)"
  type        = string
}

variable "http_port" {
  description = "Port on your laptop that forwards to port 80 inside the cluster"
  type        = number
  default     = 8080
}

variable "https_port" {
  description = "Port on your laptop that forwards to port 443 inside the cluster"
  type        = number
  default     = 8443
}
