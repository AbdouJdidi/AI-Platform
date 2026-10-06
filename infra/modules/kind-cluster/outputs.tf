# Outputs: information the module gives back after it builds the cluster.

output "cluster_name" {
  value = kind_cluster.this.name
}

output "endpoint" {
  description = "Address of the Kubernetes API"
  value       = kind_cluster.this.endpoint
}

output "kubeconfig_path" {
  value = kind_cluster.this.kubeconfig_path
}

# These three are credentials. We need them in the next step (Helm provider).
# sensitive = true hides them from the terminal output.
output "client_certificate" {
  value     = kind_cluster.this.client_certificate
  sensitive = true
}

output "client_key" {
  value     = kind_cluster.this.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = kind_cluster.this.cluster_ca_certificate
  sensitive = true
}
