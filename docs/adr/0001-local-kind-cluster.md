# ADR 0001 — Run the platform on a local kind cluster

## Status
Accepted

## Context
The project must cost $0. Managed clusters (EKS, GKE, AKS) charge for the
control plane and nodes. The dev machine has 16 GB of RAM.

## Decision
Use kind (Kubernetes in Docker), provisioned with Terraform via the
`tehcyx/kind` provider: 1 control-plane node + 2 workers.

## Consequences
- Free, reproducible: `terraform destroy` + `terraform apply` rebuilds everything.
- Same Kubernetes API as cloud clusters, so manifests and Helm charts transfer.
- No real cloud load balancers or managed storage; we use port mappings,
  ingress-nginx and in-cluster storage instead.
- Limited RAM: every workload must have resource limits.
