# ADR 0004 — Observability: kube-prometheus-stack + Loki + Alloy

## Status
Accepted

## Context
We need metrics, logs and alerts for the platform and its apps, on a
16 GB laptop, for free.

## Decision
- Metrics and alerts: kube-prometheus-stack (Prometheus, Alertmanager,
  Grafana, kube-state-metrics, node-exporter).
- Logs: Loki in SingleBinary mode with filesystem storage, 3-day retention.
- Log collection: Grafana Alloy (Promtail is deprecated), as a single
  Deployment reading logs through the Kubernetes API.
- All three are deployed by Argo CD from pinned Helm chart versions.

## Consequences
- One place (Grafana) for metrics and logs.
- Short retention (2 days metrics, 3 days logs) keeps disk usage small.
- Not highly available: one replica of each. Fine locally.
- kind-specific: control-plane components are not scraped (they listen on
  127.0.0.1 only), so those dashboards stay empty.
- Reading logs via the API does not scale to big clusters; production would
  run Alloy as a DaemonSet reading log files from each node.
