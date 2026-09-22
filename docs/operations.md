# Operations

Operational runbook for Azure Infra.

## Deployment
1. Run `./scripts/validate.sh`.
2. Run `./scripts/deploy.sh dev`.
3. Review plan output before apply.

## Cost Management
- All resources tagged with `environment` and `project`.
- Dev resources can be destroyed via `./scripts/destroy-dev.sh`.
- Run `python scripts/cost-report.py` to view mock costs.
