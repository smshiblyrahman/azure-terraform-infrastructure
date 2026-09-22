# Architecture

SELISE Azure Infrastructure Foundation.

## Network Topology
- VNet per environment.
- Public subnet (Ingress).
- Application subnet (Private App Tier).
- Database subnet (Private Data).

## Security
- NSG on subnets.
- System-assigned managed identities for VMs.
- Azure Key Vault for secrets.

## Operations
- Terraform remote state in Azure Storage.
- Environments separated by folder (`dev`, `staging`, `production`).
