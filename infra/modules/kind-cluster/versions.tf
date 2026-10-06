# Which providers (plugins) this module needs, and which versions.
terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.9"
    }
  }
}
