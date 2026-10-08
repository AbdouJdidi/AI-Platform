# ADR 0005 — Run Ollama on the host, not inside the cluster

## Status
Accepted (supersedes the first attempt, an in-cluster Ollama Deployment)

## Context
An LLM needs several GB of RAM on its own. The whole platform runs inside
Docker, and Docker's memory is shared by 3 kind nodes plus the monitoring
stack. A first attempt ran Ollama as a pod in the cluster. It competed with
everything else for memory and made the platform unstable (see the
memory-thrashing incident in the README).

## Decision
Run Ollama directly on the host machine. Pods reach it through
`host.docker.internal:11434`. Open WebUI is configured with
`OLLAMA_BASE_URL=http://host.docker.internal:11434`.

## Consequences
Good:
- The model can use all of the host's RAM (and GPU, if present), outside
  Docker's memory ceiling.
- The platform stays stable; model loading no longer starves other pods.

Bad (accepted trade-offs):
- Ollama is not deployed by GitOps: it is not reproducible from Git.
- Prometheus does not monitor it.
- Not portable: depends on Docker Desktop providing `host.docker.internal`.
- Single point of failure outside Kubernetes' self-healing.

## Production equivalent
Run the inference server in the cluster on a dedicated (GPU) node pool,
with resource requests/limits, node taints so only inference pods use it,
and autoscaling on request load (for example with KEDA).
