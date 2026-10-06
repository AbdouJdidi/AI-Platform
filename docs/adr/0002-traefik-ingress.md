# ADR 0002 — Use Traefik as the ingress controller

## Status
Accepted

## Context
The cluster needs one entry point that routes web traffic to apps by host
name. ingress-nginx, historically the most common choice, has been retired
by the Kubernetes project, so starting a new platform on it makes no sense.

## Decision
Install Traefik with its official Helm chart, managed by Terraform in a
separate `platform/` layer. Pin the chart version. Run it on the
control-plane node with hostPorts 80/443, matching the kind port mappings.

## Consequences
- Supports the standard Ingress API now and Gateway API later.
- Lightweight enough for a 16 GB laptop.
- Single replica on one node: fine locally, not highly available.
