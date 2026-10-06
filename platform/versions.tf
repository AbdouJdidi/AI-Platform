# LAYER 2: the platform add-ons that run INSIDE the cluster.
# Separate from infra/local (layer 1 = the cluster itself).

terraform {
  required_version = ">= 1.6"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
  }
}
