# ADR 0003 — GitOps with Argo CD (app of apps)

## Status
Accepted

## Context
Deploying apps with `kubectl apply` by hand is not reproducible: nobody
knows what is really running, and manual changes drift from Git.

## Decision
Install Argo CD with Terraform (platform layer). Git is the single source
of truth. A root Application watches `gitops/apps/`; each file there is an
Application pointing to an app folder in `apps/`. Automated sync with
prune and selfHeal.

## Consequences
- Deploying = `git push`. Rolling back = `git revert`.
- Manual cluster changes are undone automatically (selfHeal).
- Terraform owns the platform; Argo CD owns the apps. Clear boundary.
- The repo must be public (or Argo CD needs credentials).
