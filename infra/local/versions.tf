terraform {
  required_version = ">= 1.6"

  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.9"
    }
  }

  # State is stored locally for now (terraform.tfstate in this folder).
  # We'll talk about remote state later.
}

provider "kind" {}
