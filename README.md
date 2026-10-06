# AI Platform

A self-hosted AI platform on Kubernetes, built 100% with free and open-source
tools: Terraform, kind, Argo CD, Prometheus/Grafana/Loki, Ollama.

## Repo structure
- `infra/modules/` — reusable Terraform modules
- `infra/local/` — the local environment (your laptop)
- `platform/` — cluster add-ons (ingress, monitoring, GitOps) — coming next
- `apps/` — AI applications running on the platform — coming later
- `docs/adr/` — architecture decision records

## Quick start
```bash
cd infra/local
terraform init
terraform apply
export KUBECONFIG=$(terraform output -raw kubeconfig_path)
kubectl get nodes
```
